import Foundation

protocol CharactersPresenterProtocol {
    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response)
}

protocol CharacterProxyDisplayProtocol: AnyObject {
    func displayCharacters()
}

final class CharactersPresenter: CharactersPresenterProtocol {
    weak var display: CharactersListDisplay?

    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response) {
        switch response {
        case .content(viewModels: let characters):
            display?.displayCharacters(viewModel: .content(viewModel: characters))
        case .hidePagingLoading:
            display?.displayCharacters(viewModel: .hidePagingLoading)
        case .error:
            display?.displayCharacters(viewModel: .error)
        }
    }
}
