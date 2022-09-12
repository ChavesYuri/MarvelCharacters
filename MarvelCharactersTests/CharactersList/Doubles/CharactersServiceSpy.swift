@testable import MarvelCharacters

final class CharactersServicerSpy: CharactersServiceProtocol {

    var charactersStub: Result<[Character], CharactersServiceError>?
    private(set) var invokedLoadCharactersCount: Int = 0

    func loadCharacters(completion: @escaping (Result<[Character], CharactersServiceError>) -> Void) {
        invokedLoadCharactersCount += 1 
        charactersStub.flatMap(completion)
    }
}
