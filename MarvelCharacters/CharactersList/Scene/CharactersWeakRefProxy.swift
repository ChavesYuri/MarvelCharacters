import Foundation

final class CharactersWeakRefProxy: CharactersListDisplay {
    weak var view: (CharactersListDisplay & AnyObject)?

    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel) {
        view?.displayCharacters(viewModel: viewModel)
    }
}
