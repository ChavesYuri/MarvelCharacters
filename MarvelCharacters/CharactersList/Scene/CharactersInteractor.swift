import Foundation

protocol CharactersServiceProtocol {
    func loadCharacters(completion: @escaping (Result<CharactersResult, CharactersServiceError>) -> Void)
}

protocol CharactersInteractorProtocol {
    func loadCharacters()
}
