@testable import MarvelCharacters
import XCTest
final class CharactersInteractorTests: XCTestCase {

    private let serviceSpy = CharactersServicerSpy()
    private let presenterSpy = CharactersPresenterSpy()

    func test_loadCharacters_shouldPresentCharacters() {
        serviceSpy.charactersStub = .success([.fixture(name: "Iron Man"), .fixture()])

        let sut = makeSUT()

        sut.loadCharacters(request: .init())

        XCTAssertEqual(serviceSpy.invokedLoadCharactersCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentCharacter, 1)

        switch presenterSpy.presentCharacterParameters {
        case .content(viewModels: let characters):
            XCTAssertEqual(characters[0].name, "Iron Man")
        default:
            XCTFail("Case not expected")
        }
    }

    func test_loadCharacters_shouldPresentError() {
        serviceSpy.charactersStub = .failure(.genericError(error: NSError()))

        let sut = makeSUT()

        sut.loadCharacters(request: .init())

        switch presenterSpy.presentCharacterParameters {
        case .error:
            XCTAssertEqual(presenterSpy.invokedPresentCharacter, 1)
        default:
            XCTFail("Case not expected")
        }
    }

    func test_loadCharacters_shouldHideLoading() {
        serviceSpy.charactersStub = .failure(.limitOfPages)

        let sut = makeSUT()

        sut.loadCharacters(request: .init())

        switch presenterSpy.presentCharacterParameters {
        case .hidePagingLoading:
            XCTAssertEqual(presenterSpy.invokedPresentCharacter, 1)
        default:
            XCTFail("Case not expected")
        }
    }

    
    private func makeSUT() -> CharacterInteractor {
        CharacterInteractor(service: serviceSpy, presenter: presenterSpy)
    }
}
