import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol DataRequest {
    associatedtype Response

    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }

    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension DataRequest {
    var baseUrl: String {
        return "https://gateway.marvel.com/v1/public/"
    }

    var headers: [String : String] {
        [:]
    }

    var queryItems: [String : String] {
        [:]
    }
}
