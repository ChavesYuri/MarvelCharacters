import Foundation

struct CharactersParams: DataRequest {
    var path: String {
        "/v1/public/characters"
    }

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> CharactersDataModel {
        let decoder = JSONDecoder()
        let response = try decoder.decode(CharactersData.self, from: data)

        return response.data
    }
}
