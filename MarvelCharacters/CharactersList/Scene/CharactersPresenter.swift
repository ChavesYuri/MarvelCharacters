import Foundation
protocol CharactersPresenterProtocol {
    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response)
}

protocol CharacterProxyDisplayProtocol {
    func displayCharacters()
}

final class CharactersPresenter: CharactersPresenterProtocol {
    private let display: CharacterProxyDisplayProtocol

    init(display: CharacterProxyDisplayProtocol) {
        self.display = display
    }

    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response) {
        switch response {
        case .content:
            break
        case .hidePagingLoading:
            break
        case .error:
            break
        }
    }
}
