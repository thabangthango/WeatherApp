import Foundation

enum NetworkError: Error {
    case serverError
    case clientError
    case connectionError
    case none
}

// MARK: - Convenince init
extension NetworkError {
    init?(_ error: Error?, _ response: URLResponse?) {
        if error != nil {
            self = .clientError
        } else if (response as? HTTPURLResponse)?.isOk() == false {
            self = .serverError
        } else if error?.isConnectionError == true {
            self = .connectionError
        } else {
            return nil
        }
    }
}

// MARK: - Localized error
extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .serverError:
            return .serverErrorMessage
        case .clientError:
            return .clientErrorMessage
        case .connectionError:
            return .connectionErrorMessage
        case .none:
            return ""
        }
    }
}

fileprivate extension String {
    static let serverErrorMessage = NSLocalizedString("SERVER_SIDE_ERROR_MESSAGE", comment: "")
    static let clientErrorMessage = NSLocalizedString("CLIENT_SIDE_ERROR_MESSAGE", comment: "")
    static let connectionErrorMessage = NSLocalizedString("CONNECTION_ERROR_MESSAGE", comment: "")
}

fileprivate extension HTTPURLResponse {
    func isOk() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}

fileprivate extension Error {
    var isConnectionError: Bool {
        switch (self as NSError).code {
        case NSURLErrorNetworkConnectionLost,
             NSURLErrorNotConnectedToInternet,
             NSURLErrorCannotFindHost,
             NSURLErrorCannotConnectToHost,
             NSURLErrorDNSLookupFailed,
             NSURLErrorResourceUnavailable,
             NSURLErrorInternationalRoamingOff,
             NSURLErrorDataNotAllowed,
             NSURLErrorSecureConnectionFailed,
             NSURLErrorCannotLoadFromNetwork: return true
        default: return false
        }
    }
}
