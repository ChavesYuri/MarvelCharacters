import Foundation
protocol CharacterRepositoryProtocol {
    func fetchCharacters(model: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void)
}

enum CharactersServiceError: Error {
    case limitOfPages
    case genericError(error: Error)
}

final class CharactersService: CharactersServiceProtocol {
    private let initialOffset = 0
    private var totalItems: Int?
    private var isFetchInProgress = false
    private var characters: [CharactersResult] = []

    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func loadCharacters(completion: @escaping (Result<CharactersResult, CharactersServiceError>) -> Void) {
        guard let totalItems = totalItems else {
            /// First page
            return
        }

        if totalItems <= characters.count {
            completion(.failure(.limitOfPages))
        } else {
            let params = CharactersParams(offset: characters.count)
            fetch(params: params, completion: completion)
        }
    }

    private func fetch(params: CharactersParams, completion: @escaping (Result<CharactersResult, CharactersServiceError>) -> Void) {
        repository.fetchCharacters(model: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.characters = response.results
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            }
        }
    }
}
