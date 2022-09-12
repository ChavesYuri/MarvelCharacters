import Foundation
@testable import MarvelCharacters
final class CharactersInteractorSpy: CharactersInteractorProtocol {

    private(set) var invokedLoadCharacters: Int = 0

    func loadCharacters(request: CharactersScenarios.FetchCharacters.Request) {
        invokedLoadCharacters += 1
    }
}
