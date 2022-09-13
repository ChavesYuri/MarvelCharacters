//
//  CharactersSwiftUIView.swift
//  MarvelCharacters
//
//  Created by Yuri Chaves on 13/09/22.
//

import SwiftUI

class CharactersPublishModel: ObservableObject {
    @Published var characters: [String]
    
    init(characters: [String]) {
        self.characters = characters
    }
}

struct CharactersSwiftUIView: View {
    @ObservedObject var dataSource: CharactersPublishModel = .init(characters: [])
    
    var body: some View {
        List(dataSource.characters, id: \.self) {
            Text($0)
        }
    }
}

struct CharactersSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersSwiftUIView(dataSource:
                .init(characters: ["Spider Man", "Iron Main"])
        )
        
        CharactersSwiftUIView(dataSource:
                .init(characters: ["Spider Man", "Iron Main"])
        )
        .preferredColorScheme(.dark)
    }
}
