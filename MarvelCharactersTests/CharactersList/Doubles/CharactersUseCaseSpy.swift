@testable import MarvelCharacters
final class CharactersUseCaseSpy: RemoteCharactersUseCase {

    var charactersStub: Result<CharactersDataModel, Error>?
    private(set) var fetchCharactersParams: CharactersParams?

    func execute(request: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void) {
        fetchCharactersParams = request
        charactersStub.flatMap(completion)
    }
}
