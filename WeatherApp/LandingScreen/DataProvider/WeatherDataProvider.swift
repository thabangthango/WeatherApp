import Foundation

protocol WeatherDataProvider {

    func getCurrentWeather(
        withLat lat: String,
        lon: String,
        completion: @escaping(Weather?, NetworkError?) -> Void
    )

    func getDailyWeatherForecast(
        withLat lat: String,
        lon: String,
        completion: @escaping(WeatherForcast?, NetworkError?) -> Void
    )
}
