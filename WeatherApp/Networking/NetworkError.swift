import Foundation

enum NetworkError: Error {
    case serverError
    case clientError
    case none
}

extension NetworkError {
    
    init?(_ error: Error?, _ response: URLResponse?) {
        if error != nil {
            self = .clientError
        } else if (response as? HTTPURLResponse)?.isSuccessful() == false {
            self = .serverError
        } else {
            return nil
        }
    }
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Server error"
        case .clientError:
            return "Client error"
        case .none:
            return "No error"
        }
    }
}

fileprivate extension HTTPURLResponse {
    
    func isSuccessful() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
