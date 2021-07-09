import Foundation

protocol URLSessionClient {
    
    func performRequest<T: Codable>(
        model: T.Type,
        path: String,
        httpMethod: HTTPRequestMethod,
        params: [URLQueryItem]?,
        completion: @escaping(Result<T?, NetworkError>) -> Void
    )
}
