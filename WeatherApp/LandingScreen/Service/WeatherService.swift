import Foundation

fileprivate let apiKey = "337dbed743638aedfbd1573a379191ac"

class WeatherService: WeatherDataProvider {
    private let baseUrlString = "https://api.openweathermap.org/data/2.5"
    private var configuration = URLSessionConfiguration.default
    
    private lazy var webClient: URLSessionClient = {
        let requestManager = RequestManager(baseUrl: baseUrlString)
        return WebClient(requestManager: requestManager, configuration: configuration)
    }()
    
    func getCurrentWeather(forCity city: String, completion: @escaping(Weather?, NetworkError?) -> Void) {
        let path = "/weather"
        let params = [URLQueryItem(name: "q", value: city),
                      URLQueryItem(name: "appid", value: apiKey),
                      URLQueryItem(name: "units", value: "metric")]
        
        webClient.performRequest(
            model: Weather.self,
            path: path,
            httpMethod: .get,
            params: params
        ) { result in
            switch result {
            case .success(let weather): completion(weather, nil)
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    func getDailyWeatherForecast(forCity city: String, completion: @escaping(WeatherForcast?, NetworkError?) -> Void) {
        let path = "/forecast"
        let params = [URLQueryItem(name: "q", value: city),
                      URLQueryItem(name: "appid", value: apiKey),
                      URLQueryItem(name: "cnt", value: "5"),
                      URLQueryItem(name: "units", value: "metric")]
        
        webClient.performRequest(
            model: WeatherForcast.self,
            path: path,
            httpMethod: .get,
            params: params
        ) { result in
            switch result {
            case .success(let weather): completion(weather, nil)
            case .failure(let error): completion(nil, error)
            }
        }
    }
}
