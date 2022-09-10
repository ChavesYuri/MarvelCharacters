import Foundation
final class RemoteCharactersRepository: CharactersRepositoryProtocol {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func fetchCharacters(request: CharactersParams, completion: @escaping (Result<CharactersDataModel, Error>) -> Void) {
        network.request(request, completion: completion)
    }
}
