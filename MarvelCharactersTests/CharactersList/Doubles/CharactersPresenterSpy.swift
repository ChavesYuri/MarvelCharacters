@testable import MarvelCharacters

final class CharactersPresenterSpy: CharactersPresenterProtocol {

    private(set) var invokedPresentCharacter: Int = 0
    private(set) var presentCharacterParameters: CharactersScenarios.FetchCharacters.Response?

    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response) {
        invokedPresentCharacter += 1
        presentCharacterParameters = response
    }
}
