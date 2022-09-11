import Foundation
protocol CharactersPresenterProtocol {
    func presentCharacters(response: CharactersScenarios.FetchCharacters.Response)
}

protocol CharacterProxyDisplayProtocol: AnyObject {
    func displayCharacters()
}

final class CharactersPresenter: CharactersPresenterProtocol {
    weak var display: CharacterProxyDisplayProtocol?

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
