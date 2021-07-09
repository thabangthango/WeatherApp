import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherService = WeatherService()
        weatherService.getCurrentWeather(forCity: "London")
    }
}

