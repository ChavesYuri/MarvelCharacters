import Foundation

protocol CharactersServiceProtocol {
    func loadCharacters(completion: @escaping (Result<CharactersResult, Error>) -> Void)
}

protocol CharactersInteractorProtocol {
    func loadCharacters()
}
