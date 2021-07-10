import Foundation

public struct Weather: Codable {
    let date: Int
    let summary: [WeatherSummary]
    let details: WeatherDetails

    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case summary = "weather"
        case details = "main"
    }
}
