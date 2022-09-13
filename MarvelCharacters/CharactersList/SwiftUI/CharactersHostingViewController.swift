import Foundation
import SwiftUI
final class CharactersHostingViewController: UIHostingController<CharactersSwiftUIView> {
    private let interactor: CharactersInteractorProtocol

    init(rootView: CharactersSwiftUIView, interactor: CharactersInteractorProtocol) {
        self.interactor = interactor
        super.init(rootView: rootView)
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadCharacters(request: .init())
    }
}

extension CharactersHostingViewController: CharactersListDisplay {
    func displayCharacters(viewModel: CharactersScenarios.FetchCharacters.ViewModel) {
        switch viewModel {
        case .content(viewModel: let characters):
            rootView.dataSource = .init(characters: characters)
        case .error:
            print("Error")
            // TODO: Implement error message
        case .hidePagingLoading:
            print("Hide Loading")
        }
    }
}

extension CharactersHostingViewController: CharactersViewDelegate {
    func onLoadingCharacters() {
        interactor.loadCharacters(request: .init())
    }
}
