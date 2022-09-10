import Foundation
protocol CharacterRepositoryProtocol {
    func fetchCharacters(model: CharactersParams, completion: @escaping (Result<CharactersData, Error>) -> Void)
}
