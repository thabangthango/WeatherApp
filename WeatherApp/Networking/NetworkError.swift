import Foundation

enum NetworkError: Error {
    case serverError
    case clientError
    case none
}

// MARK:- Convenince init
extension NetworkError {
    init?(_ error: Error?, _ response: URLResponse?) {
        if error != nil {
            self = .clientError
        } else if (response as? HTTPURLResponse)?.isOk() == false {
            self = .serverError
        } else {
            return nil
        }
    }
}

// MARK:- Localized error
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
    func isOk() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
