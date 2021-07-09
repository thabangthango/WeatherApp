import Foundation

fileprivate let apiKey = "337dbed743638aedfbd1573a379191ac"

class WeatherService {
    private let urlString = "https://api.openweathermap.org/data/2.5"
    private var configuration = URLSessionConfiguration.default
    
    private lazy var webClient: URLSessionClient = {
        return WebClient(baseUrl: urlString, configuration: configuration)
    }()
    
    func getCurrentWeather(forCity city: String) {
        let path = "/weather"
        let params = [URLQueryItem(name: "q", value: city), URLQueryItem(name: "appid", value: apiKey)]
        
        webClient.performRequest(
            model: CurrentWeather.self,
            path: path,
            httpMethod: .get,
            params: params
        ) { [weak self] result in
            
        }
    }
}

struct CurrentWeather: Codable {
    let summary: [WeatherSummary]
    let details: WeatherDetails
    
    private enum CodingKeys: String, CodingKey {
        case summary = "weather"
        case details = "main"
    }
}

struct WeatherSummary: Codable {
    let main: String
    let description: String
    let icon: String
}

struct WeatherDetails: Codable {
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
