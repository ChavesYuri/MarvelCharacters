import Foundation
import UIKit

protocol CharactersListDisplay: AnyObject {
    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel)
}

protocol CharactersViewProtocol: UIView {
    func updateDataSource(_ characters: [String])
    func hideLoading()
}

final class CharactersListViewController: UIViewController {
    private let charactersView: CharactersViewProtocol
    private let interactor: CharactersInteractorProtocol

    init(view: CharactersViewProtocol,
         interactor: CharactersInteractorProtocol
    ) {
        self.charactersView = view
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = charactersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Characters"
        interactor.loadCharacters(request: .init())
    }
}

extension CharactersListViewController: CharactersListDisplay {
    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel) {
        switch viewModel {
        case .content(viewModel: let characters):
            charactersView.updateDataSource(characters)
        case .error:
            // TODO: Implement error message
            charactersView.hideLoading()
        case .hidePagingLoading:
            charactersView.hideLoading()
        }
    }
}

extension CharactersListViewController: CharactersViewDelegate {
    func onLoadingCharacters() {
        interactor.loadCharacters(request: .init())
    }
}
