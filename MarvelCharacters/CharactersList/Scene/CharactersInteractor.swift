import Foundation

protocol CharactersServiceProtocol {
    func loadCharacters(completion: @escaping (Result<[Character], CharactersServiceError>) -> Void)
}

protocol CharactersInteractorProtocol {
    func loadCharacters()
}
