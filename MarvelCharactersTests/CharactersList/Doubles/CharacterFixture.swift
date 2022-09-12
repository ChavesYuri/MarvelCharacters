@testable import MarvelCharacters
extension Character {
    static func fixture(
        id: Int = 0,
        name: String = "Siper Man",
        resultDescription: String = "",
        thumbnail: Thumbnail = .init(path: "", thumbnailExtension: ""),
        resourceURI: String = ""
    ) -> Self {
        .init(
            id: id,
            name: name,
            resultDescription: resultDescription,
            thumbnail: thumbnail,
            resourceURI: resourceURI
        )
    }
}
