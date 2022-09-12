import Foundation

// MARK: - Characters
struct CharactersData: Decodable {
    let data: CharactersDataModel
}

// MARK: - DataClass
struct CharactersDataModel: Decodable {
    let offset, limit, total: Int
    let results: [Character]
}

// MARK: - Result
struct Character: Decodable {
    let id: Int
    let name, resultDescription: String
    let thumbnail: Thumbnail
    let resourceURI: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, resourceURI
    }
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
