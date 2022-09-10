import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

enum ErrorResponse: String, Error {
    case invalidEndpoint
}

final class DefaultNetworkService: NetworkService {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {

        guard var urlComponent = URLComponents(string: request.baseUrl + request.path) else {
            let error = NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )

            return completion(.failure(error))
        }

        var queryItems: [URLQueryItem] = []

        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }

        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else {
            let error = NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )

            return completion(.failure(error))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = buildHeader(headers: request.headers)

        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NSError()))
            }

            guard let data = data else {
                return completion(.failure(NSError()))
            }

            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }

    private func buildHeader(headers: [String: String]) -> [String: String] {
        // TODO: Create algorithm to generate hash according to ts
        let apiKey = "42d211b71d86afb742cb3ba128f95bc8"
        let hashAPI = "4fb1d7ac3e338c099db554a9557d123c"
        let timesTemp = "1"

        var header = ["apikey": apiKey, "hash": hashAPI, "ts": timesTemp]

        headers.forEach {
            header[$0.key] = $0.value
        }

        return headers
    }
}
