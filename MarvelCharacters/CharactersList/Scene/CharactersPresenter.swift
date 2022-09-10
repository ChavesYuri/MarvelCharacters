import Foundation
protocol CharactersPresenterProtocol {
    func presentCharacters(characters: [Character])
    func presentError(error: Error)
}

final class CharactersPresenter: CharactersPresenterProtocol {
    func presentError(error: Error) {
        <#code#>
    }

    func presentCharacters(characters: [Character]) {
        
    }
}
