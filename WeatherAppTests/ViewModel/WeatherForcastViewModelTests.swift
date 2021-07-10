import XCTest
import CoreLocation
@testable import WeatherApp

class WeatherForcastViewModelTests: XCTestCase {
    private var systemUnderTest: WeatherForcastViewModel!

    override func setUp() {
        super.setUp()
        setupSystemUnderTest()
    }

    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }

    func testViewModelReturnsExpectedNumberOfDaysForEmptyData() {
        systemUnderTest.configure(dataProvider: EmptyWeatherDataProviderStub())

        systemUnderTest.fetchWeatherInfo(with: CLLocationCoordinate2D(), completion: {_ in })

        XCTAssertEqual(0, systemUnderTest.numberOfDays())
    }

    func testViewModelReturnsExpectedNumberOfDays() {
        XCTAssertEqual(5, systemUnderTest.numberOfDays())
    }

    func testViewModelReturnsCorrectWeatherForSpecifiedDay() {
        let actualWeather1 = systemUnderTest.weather(forDay: 0)
        let actualWeather2 = systemUnderTest.weather(forDay: 1)
        let actualWeather3 = systemUnderTest.weather(forDay: 2)
        let actualWeather4 = systemUnderTest.weather(forDay: 3)
        let actualWeather5 = systemUnderTest.weather(forDay: 4)
        let actualWeather6 = systemUnderTest.weather(forDay: 5)

        XCTAssertEqual(Weather.day1.details.temp, actualWeather1?.details.temp)
        XCTAssertEqual(Weather.day2.details.temp, actualWeather2?.details.temp)
        XCTAssertEqual(Weather.day3.details.temp, actualWeather3?.details.temp)
        XCTAssertEqual(Weather.day4.details.temp, actualWeather4?.details.temp)
        XCTAssertEqual(Weather.day5.details.temp, actualWeather5?.details.temp)
        XCTAssertNil(actualWeather6)
    }

    func testViewModelReturnsCorrentCurrentWeatherDetails() {
        let actualCurrentWeather = systemUnderTest.currentWeather

        XCTAssertEqual("Monday", actualCurrentWeather?.day)
        XCTAssertEqual(.cloudy, actualCurrentWeather?.type)
        XCTAssertEqual("25°", actualCurrentWeather?.temp)
        XCTAssertEqual("30°", actualCurrentWeather?.minTemp)
        XCTAssertEqual("20°", actualCurrentWeather?.maxTemp)
    }

    private func setupSystemUnderTest() {
        let dataProvider = WeatherDataProviderStub()
        systemUnderTest = WeatherForcastViewModel(dataProvider: dataProvider)
        systemUnderTest.fetchWeatherInfo(with: CLLocationCoordinate2D(), completion: {_ in })
    }
}
