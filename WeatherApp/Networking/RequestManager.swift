import Foundation

protocol URLSessionRequestManager {
    
    func urlRequest(
        with path: String,
        httpMethod: HTTPRequestMethod,
        queryParams: [URLQueryItem]?
    ) -> URLRequest?
}

class RequestManager: URLSessionRequestManager {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func urlRequest(
        with path: String,
        httpMethod: HTTPRequestMethod,
        queryParams: [URLQueryItem]?
    ) -> URLRequest? {
        
        guard let url = createUrl(with: path, params: queryParams) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    private func createUrl(with path: String, params: [URLQueryItem]?) -> URL? {
        var components = URLComponents(string: baseUrl)
        components?.path += path
        components?.queryItems = params
        return components?.url
    }
}
