@testable import MarvelCharacters
import XCTest
final class CharactersServiceTests: XCTestCase {
    private let repositoryStub = CharactersRepositoryStub()

    func test_loadCharacters_whenIsFirstRequest() {
        repositoryStub.charactersStub = .success(.fixture())
    }

    private func makeSUT() -> CharactersService {
        CharactersService(repository: repositoryStub)
    }
}

extension CharactersDataModel {
    static func fixture(
        offset: Int = 0,
        limit: Int = 20,
        total: Int = 0,
        results: [Character] = []
    ) -> Self {
        .init(
            offset: offset,
            limit: limit,
            total: total,
            results: results
        )
    }
}
