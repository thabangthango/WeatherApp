import Foundation

public struct WeatherForcast: Codable {
    let dailyForcasts: [Weather]
    
    private enum CodingKeys: String, CodingKey {
        case dailyForcasts = "list"
    }
}
