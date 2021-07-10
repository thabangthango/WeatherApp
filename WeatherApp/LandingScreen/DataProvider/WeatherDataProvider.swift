import Foundation

protocol WeatherDataProvider {
    
    func getCurrentWeather(forCity city: String, completion: @escaping(Weather?, NetworkError?) -> Void)
    
    func getDailyWeatherForecast(forCity city: String, completion: @escaping(WeatherForcast?, NetworkError?) -> Void)
}
