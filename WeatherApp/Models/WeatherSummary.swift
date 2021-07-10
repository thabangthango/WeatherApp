import Foundation

public struct WeatherSummary: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
