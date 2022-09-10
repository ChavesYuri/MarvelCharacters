import Foundation
import XCTest
@testable import MarvelCharacters

final class CharactersListViewControllerTests: XCTestCase {

    func test_viewDidLoad_ShouldPresentTitle() {
        let sut = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.title, "Marvel Characters")
    }

    func test_numberOfRowsInSection() {
        let dataSourceStub = ["Spider Man", "Iron Man"]
        let sut = makeSUT(dataSource: dataSourceStub)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }

    func makeSUT(dataSource: [String] = []) -> CharactersListViewController {
        let viewController = CharactersListViewController(dataSource: dataSource)
        return viewController
    }
}
