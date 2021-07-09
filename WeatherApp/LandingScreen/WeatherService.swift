import Foundation

fileprivate let apiKey = "337dbed743638aedfbd1573a379191ac"

class WeatherService {
    private let baseUrlString = "https://api.openweathermap.org/data/2.5"
    private var configuration = URLSessionConfiguration.default
    
    private lazy var webClient: URLSessionClient = {
        let requestManager = RequestManager(baseUrl: baseUrlString)
        return WebClient(requestManager: requestManager, configuration: configuration)
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
