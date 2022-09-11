import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

enum ErrorResponse: String, Error {
    case invalidEndpoint
    case invalidPath
    case invalidBaseURL
}

final class DefaultNetworkService: NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {

        guard let baseURL = URL(string: request.baseUrl) else {
            return completion(.failure(ErrorResponse.invalidBaseURL))
        }

        guard var urlComponent = URLComponents(string: request.path) else {
            let error = NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )

            return completion(.failure(error))
        }

        var queryItems: [URLQueryItem] = defaultParameters()

        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }

        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url(relativeTo: baseURL) else {
            let error = NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )

            return completion(.failure(error))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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

    private func defaultParameters() -> [URLQueryItem] {
        // TODO: Create algorithm to generate hash according to ts
        let apiKey = "42d211b71d86afb742cb3ba128f95bc8"
        let hashAPI = "4fb1d7ac3e338c099db554a9557d123c"
        let timesTemp = "1"

        return [.init(name: "apikey", value: apiKey),
                .init(name: "hash", value: hashAPI),
                .init(name: "ts", value: timesTemp)]
    }
}
