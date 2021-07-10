import UIKit

enum WeatherType: String {
    case cloudy = "Cloudy"
    case sunny = "Sunny"
    case rainy = "Rainy"
    
    var backgroundImage: UIImage {
        switch self {
        case .cloudy: return UIImage()
        case .rainy: return UIImage()
        case .sunny: return UIImage()
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .cloudy: return .white
        case .rainy: return .white
        case .sunny: return .white
        }
    }
}
