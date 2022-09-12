import Foundation

final class RemoteLoadCharacters: RemoteCharactersUseCase {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func execute(request: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void) {
        network.request(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
