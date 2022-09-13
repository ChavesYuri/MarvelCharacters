import Foundation

protocol CharactersPresenterProtocol {
    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response)
}

final class CharactersPresenter: CharactersPresenterProtocol {
    let display: CharactersListDisplay

    init(display: CharactersListDisplay) {
        self.display = display
    }

    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response) {
        switch response {
        case .content(viewModels: let characters):
            display.displayCharacters(viewModel: .content(viewModel: characters))
        case .hidePagingLoading:
            display.displayCharacters(viewModel: .hidePagingLoading)
        case .error:
            display.displayCharacters(viewModel: .error)
        }
    }
}
