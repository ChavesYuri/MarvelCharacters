import Foundation

protocol CharactersServiceProtocol {
    func loadCharacters(completion: @escaping (Result<[Character], CharactersServiceError>) -> Void)
}

protocol CharactersInteractorProtocol {
    func loadCharacters()
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

    func loadCharacters() {
        service.loadCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.presenter.presentCharacters(characters: characters)
            case .failure(let error):
                break
            }
        }
    }

    private func errorHandler(errorType: CharactersServiceError) {
        switch errorType {
        case .limitOfPages:
            break
        case .genericError:
            break
        }
    }
}
