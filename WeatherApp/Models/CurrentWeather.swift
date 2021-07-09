import Foundation

struct CurrentWeather: Codable {
    let summary: [WeatherSummary]
    let details: WeatherDetails
    
    private enum CodingKeys: String, CodingKey {
        case summary = "weather"
        case details = "main"
    }
}
