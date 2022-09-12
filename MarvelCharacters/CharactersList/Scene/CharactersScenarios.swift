import Foundation

enum CharactersScenarios {
    enum FetchCharacters {
        struct Request {}

        enum Response {
            case content(viewModels: [Character])
            case hidePagingLoading
            case error
        }

        enum ViewModel {
            case content(viewModel: [String])
            case hidePagingLoading
            case error
        }
    }
}
