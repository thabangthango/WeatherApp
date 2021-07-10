import UIKit

enum WeatherType: String {
    case cloudy = "Cloudy"
    case sunny = "Sunny"
    case rainy = "Rainy"
    
    var backgroundImage: UIImage? {
        switch self {
        case .cloudy: return .cloudyBackground
        case .rainy: return .rainyBackground
        case .sunny: return .sunnyBackground
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .cloudy: return .cloudyIcon
        case .rainy: return .rainyIcon
        case .sunny: return .sunnyIcon
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .cloudy: return .cloudy
        case .rainy: return .rainy
        case .sunny: return .sunny
        }
    }
}

fileprivate extension UIColor {
    static let sunny = UIColor(displayP3Red: 71/255, green: 171/255, blue: 45/255, alpha: 1)
    static let rainy = UIColor(displayP3Red: 87/255, green: 87/255, blue: 93/255, alpha: 1)
    static let cloudy = UIColor(displayP3Red: 84/255, green: 113/255, blue: 122/255, alpha: 1)
}

fileprivate extension UIImage {
    static let sunnyBackground = UIImage(named: "forest_sunny", in: Bundle.main, compatibleWith: nil)
    static let rainyBackground = UIImage(named: "forest_rainy", in: Bundle.main, compatibleWith: nil)
    static let cloudyBackground = UIImage(named: "forest_cloudy", in: Bundle.main, compatibleWith: nil)
    static let sunnyIcon = UIImage(named: "sunny_icon", in: Bundle.main, compatibleWith: nil)
    static let rainyIcon = UIImage(named: "rainy_icon", in: Bundle.main, compatibleWith: nil)
    static let cloudyIcon = UIImage(named: "cloudy_icon", in: Bundle.main, compatibleWith: nil)
}
