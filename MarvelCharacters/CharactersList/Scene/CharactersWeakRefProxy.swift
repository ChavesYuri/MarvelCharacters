import Foundation

final class CharactersWeakRefProxy: CharactersListDisplay {
    weak var view: CharactersListDisplay?

    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel) {
        view?.displayCharacters(viewModel: viewModel)
    }
}
