import Foundation
import XCTest
@testable import MarvelCharacters

final class CharactersListViewControllerTests: XCTestCase {
    let interactorSpy = CharactersInteractorSpy()

    func test_viewDidLoad_ShouldPresentTitle() {
        let sut = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.title, "Marvel Characters")
    }

    func test_viewDidLoad_shouldCallInteractor() {
        let sut = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertEqual(interactorSpy.invokedLoadCharacters, 1)
    }

    func test_numberOfRowsInSection() {
        let sut = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func makeSUT() -> CharactersListViewController {
        let viewController = CharactersListViewController(interactor: interactorSpy)
        return viewController
    }
}
