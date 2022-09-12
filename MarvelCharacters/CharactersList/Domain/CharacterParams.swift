import Foundation

struct CharactersParams: DataRequest {
    let offset: Int
    let limit: Int = 20

    var path: String {
        "/v1/public/characters"
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [String : String] {
        [
            "offset": "\(offset)",
            "limit": "\(limit)"
        ]
    }

    func decode(_ data: Data) throws -> CharactersData {
        let decoder = JSONDecoder()
        let response = try decoder.decode(CharactersData.self, from: data)

        return response
    }
}
