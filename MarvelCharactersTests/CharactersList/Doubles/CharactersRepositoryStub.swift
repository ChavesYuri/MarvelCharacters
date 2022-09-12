@testable import MarvelCharacters
final class CharactersRepositoryStub: CharactersRepositoryProtocol {

    var charactersStub: Result<CharactersDataModel, Error>?
    private(set) var fetchCharactersParams: CharactersParams?

    func fetchCharacters(request: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void) {
        fetchCharactersParams = request
        charactersStub.flatMap(completion)
    }
}
