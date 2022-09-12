import Foundation

final class RemoteLoadCharacters: RemoteCharactersUseCase {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func execute(request: Request, completion: @escaping (RemoteCharactersUseCase.Result) -> Void) {
        network.request(request) { result in
            switch result {
            case .success(let response):
                completion(.success(RemoteLoadCharacters.map(response.data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private static func map(
            _ remoteModel: CharactersDataModel
        ) -> CharactersModel {
            .init(offset: remoteModel.offset,
                  limit: remoteModel.limit,
                  total: remoteModel.total,
                  characters: remoteModel.results.map({ .init(name: $0.name) })
            )
        }
}
