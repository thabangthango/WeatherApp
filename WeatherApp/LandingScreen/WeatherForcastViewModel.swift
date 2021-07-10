import UIKit

fileprivate let dayDateFormatter: DateFormatter = NSDate.dayFormatter

class WeatherForcastViewModel {
    private var weatherDataProvider: WeatherDataProvider
    private var weatherForcast: WeatherForcast?
    private(set) var currentWeather: Weather?
    
    init(dataProvider: WeatherDataProvider) {
        self.weatherDataProvider = dataProvider
    }
    
    func fetchWeatherInfo(forCity city: String, completion: @escaping(NetworkError?) -> Void) {
        let dispatchGroup = DispatchGroup()
        var networkError: NetworkError?
        
        dispatchGroup.enter()
        weatherDataProvider.getCurrentWeather(forCity: city) { [weak self] response, error in
            self?.currentWeather = response
            networkError = error
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        weatherDataProvider.getDailyWeatherForecast(forCity: city) { [weak self] response, error in
            self?.weatherForcast = response
            networkError = error
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(networkError)
        }
    }
    
    func numberOfDays() -> Int {
        weatherForcast?.dailyForcasts.count ?? 0
    }
    
    func weather(forDay day: Int) -> Weather? {
        guard let dailyForcast = weatherForcast?.dailyForcasts[day] else {
            return nil
        }
        return dailyForcast
    }
}

// MARK: - Weather data formating extension
fileprivate extension Weather {
    
    var day: String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        return dayDateFormatter.string(from: date)
    }
    
    var type: WeatherType? {
        guard let weatherCode = summary.first?.id else { return nil }
        switch weatherCode {
        case 200...781: return .rainy
        case 800: return .sunny
        case 801...804: return .cloudy
        default: return nil
        }
    }
    
    var temp: String {
        String(format:"%.0f%@", details.temp, "\u{00B0}")
    }
    
    var minTemp: String {
        String(format:"%.0f%@", details.tempMax, "\u{00B0}")
    }
    
    var maxTemp: String {
        String(format:"%.0f%@", details.tempMin, "\u{00B0}")
    }
}

// MARK: - Date formatter
fileprivate extension NSDate {

    static var dayFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.calendar = Calendar.current
        return dateFormatter
    }
}
