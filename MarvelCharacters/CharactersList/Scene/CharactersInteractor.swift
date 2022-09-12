import Foundation

protocol CharactersServiceProtocol {
    func loadCharacters(completion: @escaping (Result<[String], CharactersServiceError>) -> Void)
}

protocol CharactersInteractorProtocol {
    func loadCharacters(request: CharactersScenarios.FetchCharacters.Request)
}

final class CharacterInteractor: CharactersInteractorProtocol {
    private let service: CharactersServiceProtocol
    private let presenter: CharactersPresenterProtocol

    init(
        service: CharactersServiceProtocol,
        presenter: CharactersPresenterProtocol
    ) {
        self.service = service
        self.presenter = presenter
    }

    func loadCharacters(request: CharactersScenarios.FetchCharacters.Request) {
        service.loadCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.presenter.presentCharacters(response: .content(viewModels: characters))
            case .failure(let error):
                self?.errorHandler(errorType: error)
            }
        }
    }

    private func errorHandler(errorType: CharactersServiceError) {
        switch errorType {
        case .limitOfPages:
            self.presenter.presentCharacters(response: .hidePagingLoading)
        case .genericError:
            self.presenter.presentCharacters(response: .error)
        }
    }
}
