import Foundation

class WebClient: URLSessionClient {
    private let session: URLSession
    private let requestManager: URLSessionRequestManager

    init(requestManager: URLSessionRequestManager, configuration: URLSessionConfiguration) {
        self.requestManager = requestManager
        self.session = URLSession(configuration: configuration)
    }

    func performRequest<T: Codable>(
        model: T.Type,
        path: String,
        httpMethod: HTTPRequestMethod,
        params: [URLQueryItem]?,
        completion: @escaping(Result<T?, NetworkError>) -> Void
    ) {
        guard let request = requestManager.urlRequest(
                with: path,
                httpMethod: httpMethod,
                queryParams: params) else { return }

        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError(error, response) ?? .none))
                }
                return
            }
            DispatchQueue.main.async {
                self.parseResponse(with: model, data: data, response: response, completion: completion)
            }
        }

        task.resume()
    }

    private func parseResponse<T: Codable>(
        with model: T.Type,
        data: Data?,
        response: URLResponse?,
        completion: @escaping(Result<T?, NetworkError>) -> Void
    ) {
        guard let data = data else {
            completion(.failure(NetworkError(nil, response) ?? .none))
            return
        }

        do {
            let dataModel = try JSONDecoder().decode(model.self, from: data)
            completion(.success(dataModel))
        } catch {
            debugPrint("Error encoding body: \(error)")
            completion(.failure(NetworkError(nil, response) ?? .none))
        }
    }
}
