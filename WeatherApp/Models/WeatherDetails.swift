import Foundation

public struct WeatherDetails: Codable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float

    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
