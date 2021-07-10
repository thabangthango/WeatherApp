import Foundation

fileprivate let apiKey = "337dbed743638aedfbd1573a379191ac"
fileprivate let unitType = "metric"

class WeatherService: WeatherDataProvider {
    private let baseUrlString = "https://api.openweathermap.org/data/2.5"
    private var configuration = URLSessionConfiguration.default
    
    private lazy var webClient: URLSessionClient = {
        let requestManager = RequestManager(baseUrl: baseUrlString)
        return WebClient(requestManager: requestManager, configuration: configuration)
    }()
    
    func getCurrentWeather(withLat lat: String, lon: String, completion: @escaping(Weather?, NetworkError?) -> Void) {
        let path = "/weather"
        let params = [URLQueryItem(name: "lat", value: lat),
                      URLQueryItem(name: "lon", value: lon),
                      URLQueryItem(name: "appid", value: apiKey),
                      URLQueryItem(name: "units", value: unitType)]
        
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
    
    func getDailyWeatherForecast(withLat lat: String, lon: String, completion: @escaping(WeatherForcast?, NetworkError?) -> Void) {
        let path = "/forecast"
        let params = [URLQueryItem(name: "lat", value: lat),
                      URLQueryItem(name: "lon", value: lon),
                      URLQueryItem(name: "appid", value: apiKey),
                      URLQueryItem(name: "units", value: unitType)]
        
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
