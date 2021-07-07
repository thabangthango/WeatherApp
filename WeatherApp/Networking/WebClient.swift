import Foundation

protocol URLSessionClient {
    func performRequest<T: Codable>(
        path: String,
        httpMethod: HTTPRequestMethod,
        params: [URLQueryItem]?,
        completion: @escaping(Result<T?, NetworkError>) -> Void
    )
}

class WebClient: URLSessionClient {
    private let session: URLSession
    private let requestManager: RequestManager
    
    init(baseUrl: String, configuration: URLSessionConfiguration) {
        self.requestManager = RequestManager(baseUrl: baseUrl)
        self.session = URLSession(configuration: configuration)
    }
    
    func performRequest<T: Codable>(
        path: String,
        httpMethod: HTTPRequestMethod,
        params: [URLQueryItem]?,
        completion: @escaping(Result<T?, NetworkError>) -> Void
    ) {
        guard let request = requestManager.urlRequest(
                with: path,
                httpMethod: httpMethod,
                queryParams: params)
        else {
            return
        }
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(NetworkError(error, response) ?? .none))
                    return
                }
                completion(.success(self?.response(from: data, model: T.self)))
            }
        }
        
        task.resume()
    }
    
    private func response<T: Codable>(from data: Data?, model: T.Type) -> T? {
        guard let data = data else {
            return nil
        }
        var dataModel: T?
        
        do {
            let decoder = JSONDecoder()
            dataModel = try decoder.decode(model, from: data)
        } catch {
            // do something
        }
        
        return dataModel
    }
}

extension HTTPURLResponse {
    
    func isSuccessful() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
