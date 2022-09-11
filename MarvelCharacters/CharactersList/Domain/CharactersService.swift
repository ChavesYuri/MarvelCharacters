import Foundation

enum CharactersServiceError: Error {
    case limitOfPages
    case genericError(error: Error)
}

protocol CharactersRepositoryProtocol {
    func fetchCharacters(request: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void)
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
        guard !isFetchInProgress else { return }

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
        isFetchInProgress = true

        repository.fetchCharacters(request: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            case .success(let response):
                if params.offset == self.initialOffset {
                    self.characters = response.results
                } else {
                    self.characters.append(contentsOf: response.results)
                }

                self.totalItems = response.total
                completion(.success(self.characters))
            }

            self.isFetchInProgress = false
        }
    }
}
