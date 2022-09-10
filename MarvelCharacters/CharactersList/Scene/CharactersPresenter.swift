import Foundation
protocol CharactersPresenterProtocol {
    func presentCharacters(characters: [Character])
    func presentError(error: Error)
}

protocol CharacterProxyDisplayProtocol {
    func displayCharacters()
}

final class CharactersPresenter: CharactersPresenterProtocol {
    private let display: CharacterProxyDisplayProtocol

    init(display: CharacterProxyDisplayProtocol) {
        self.display = display
    }
    
    func presentError(error: Error) {
        <#code#>
    }

    func presentCharacters(characters: [Character]) {
        
    }
}
