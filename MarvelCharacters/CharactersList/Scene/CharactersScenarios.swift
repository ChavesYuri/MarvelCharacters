//
//  CharactersScenarios.swift
//  MarvelCharacters
//
//  Created by Yuri Chaves on 10/09/22.
//

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
            case content(viewModel: [Character])
            case hidePagingLoading
            case error
        }
    }
}
