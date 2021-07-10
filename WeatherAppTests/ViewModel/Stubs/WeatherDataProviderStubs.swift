import Foundation
@testable import WeatherApp

class WeatherDataProviderStub: WeatherDataProvider {
    private let weatherForcast = WeatherForcast(dailyForcasts: [.day1, .day2, .day3, .day4, .day5])
    private let currentWeather: Weather = .day1

    func getCurrentWeather(withLat lat: String, lon: String, completion: @escaping (Weather?, NetworkError?) -> Void) {
        completion(currentWeather, nil)
    }

    func getDailyWeatherForecast(
        withLat lat: String,
        lon: String,
        completion: @escaping (WeatherForcast?, NetworkError?) -> Void
    ) {
        completion(weatherForcast, nil)
    }
}

class EmptyWeatherDataProviderStub: WeatherDataProvider {

    func getCurrentWeather(
        withLat lat: String,
        lon: String,
        completion: @escaping (Weather?, NetworkError?) -> Void
    ) {
        completion(nil, nil)
    }

    func getDailyWeatherForecast(
        withLat lat: String,
        lon: String,
        completion: @escaping (WeatherForcast?, NetworkError?) -> Void
    ) {
        completion(nil, nil)
    }
}

extension Weather {
    static let day1 = Weather(date: 1485790200, summary: [.cloudyWeather], details: .weatherDetails1)
    static let day2 = Weather(date: 1485790200, summary: [.cloudyWeather], details: .weatherDetails1)
    static let day3 = Weather(date: 1485820800, summary: [.clearWeather], details: .weatherDetails2)
    static let day4 = Weather(date: 1485790200, summary: [.clearWeather], details: .weatherDetails2)
    static let day5 = Weather(date: 1486220400, summary: [.rainyWeather], details: .weatherDetails3)
}

extension WeatherSummary {
    static let cloudyWeather = WeatherSummary(id: 802, main: "Clouds", description: "scattered clouds", icon: "03n")
    static let clearWeather = WeatherSummary(id: 800, main: "Clear", description: "clear sky", icon: "03n")
    static let rainyWeather = WeatherSummary(id: 600, main: "Snow", description: "light snow", icon: "03n")
}

extension WeatherDetails {
    static let weatherDetails1 = WeatherDetails(temp: 25, feelsLike: 25, tempMin: 20, tempMax: 30)
    static let weatherDetails2 = WeatherDetails(temp: 35, feelsLike: 35, tempMin: 30, tempMax: 36)
    static let weatherDetails3 = WeatherDetails(temp: 0, feelsLike: 0, tempMin: -2, tempMax: 5)
}
