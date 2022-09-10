import Foundation
protocol CharactersRepositoryProtocol {
    func fetchCharacters(request: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void)
}

enum CharactersServiceError: Error {
    case limitOfPages
    case genericError(error: Error)
}

final class CharactersService: CharactersServiceProtocol {
    private let initialOffset = 0
    private var totalItems: Int?
    private var isFetchInProgress = false
    private var characters: [Character] = []

    private let repository: CharactersRepositoryProtocol

    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }

    func loadCharacters(completion: @escaping (Result<[Character], CharactersServiceError>) -> Void) {
        guard let totalItems = totalItems else {
            /// First page
            fetch(params: .init(offset: initialOffset), completion: completion)
            return
        }

        if totalItems <= characters.count {
            completion(.failure(.limitOfPages))
        } else {
            let params = CharactersParams(offset: characters.count)
            fetch(params: params, completion: completion)
        }
    }

    private func fetch(params: CharactersParams, completion: @escaping (Result<[Character], CharactersServiceError>) -> Void) {
        repository.fetchCharacters(request: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.characters = response.results
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            }
        }
    }
}
