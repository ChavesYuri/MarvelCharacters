import Foundation

enum CharactersServiceError: Error {
    case limitOfPages
    case genericError(error: Error)
}

struct CharactersModel {
    let offset, limit, total: Int
    let characters: [CharacterModel]
}

struct CharacterModel {
    let name: String
}

protocol RemoteCharactersUseCase {
    typealias Request = CharactersParams
    typealias Result = Swift.Result<CharactersModel, Error>
    func execute(request: Request, completion: @escaping (Result) -> Void)
}

final class CharactersService: CharactersServiceProtocol {
    private let initialOffset = 0
    private var totalItems: Int?
    private var isFetchInProgress = false
    private var characters: [String] = []

    private let remoteCharacters: RemoteCharactersUseCase

    init(remoteCharacters: RemoteCharactersUseCase) {
        self.remoteCharacters = remoteCharacters
    }

    func loadCharacters(completion: @escaping (Result<[String], CharactersServiceError>) -> Void) {
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

    private func fetch(params: CharactersParams, completion: @escaping (Result<[String], CharactersServiceError>) -> Void) {
        isFetchInProgress = true

        remoteCharacters.execute(request: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            case .success(let response):
                if params.offset == self.initialOffset {
                    self.characters = response.characters.map({ $0.name })
                } else {
                    self.characters.append(contentsOf: response.characters.map({ $0.name }))
                }

                self.totalItems = response.total
                completion(.success(self.characters))
            }

            self.isFetchInProgress = false
        }
    }
}
