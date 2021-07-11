import XCTest
@testable import WeatherApp

class WeatherInformationFormattingTests: XCTestCase {
    private var cloudyWeatherUnderTest: Weather!
    private var sunnyWeatherUnderTest: Weather!
    private var rainyWeatherUnderTest: Weather!

    override func setUp() {
        super.setUp()
        cloudyWeatherUnderTest = .day1
        sunnyWeatherUnderTest = .day3
        rainyWeatherUnderTest = .day5
    }

    override func tearDown() {
        cloudyWeatherUnderTest = nil
        sunnyWeatherUnderTest = nil
        rainyWeatherUnderTest = nil
        super.tearDown()
    }

    func testWeatherReturnsExpectedDay() {
        XCTAssertEqual("Monday, 05 PM", cloudyWeatherUnderTest.day)
        XCTAssertEqual("Tuesday, 02 AM", sunnyWeatherUnderTest.day)
        XCTAssertEqual("Saturday, 05 PM", rainyWeatherUnderTest.day)
    }

    func testWeatherReturnsExpectedWeatherType() {
        XCTAssertEqual(.cloudy, cloudyWeatherUnderTest.type)
        XCTAssertEqual(.sunny, sunnyWeatherUnderTest.type)
        XCTAssertEqual(.rainy, rainyWeatherUnderTest.type)
    }

    func testWeatherReturnsExpectedWeatherBackgroundColor() {
        XCTAssertEqual(.cloudy, cloudyWeatherUnderTest.type?.backgroundColor)
        XCTAssertEqual(.sunny, sunnyWeatherUnderTest.type?.backgroundColor)
        XCTAssertEqual(.rainy, rainyWeatherUnderTest.type?.backgroundColor)
    }

    func testWeatherReturnsExpectedWeatherBackgroundImage() {
        XCTAssertEqual(.cloudyBackground, cloudyWeatherUnderTest.type?.backgroundImage)
        XCTAssertEqual(.sunnyBackground, sunnyWeatherUnderTest.type?.backgroundImage)
        XCTAssertEqual(.rainyBackground, rainyWeatherUnderTest.type?.backgroundImage)
    }

    func testWeatherReturnsExpectedWeatherBackgroundIcon() {
        XCTAssertEqual(.cloudyIcon, cloudyWeatherUnderTest.type?.icon)
        XCTAssertEqual(.sunnyIcon, sunnyWeatherUnderTest.type?.icon)
        XCTAssertEqual(.rainyIcon, rainyWeatherUnderTest.type?.icon)
    }

    func testWeatherReturnsExpectedWeatherTemp() {
        XCTAssertEqual("25°", cloudyWeatherUnderTest.temp)
        XCTAssertEqual("35°", sunnyWeatherUnderTest.temp)
        XCTAssertEqual("0°", rainyWeatherUnderTest.temp)
    }

    func testWeatherReturnsExpectedMinWeatherTemp() {
        XCTAssertEqual("30°", cloudyWeatherUnderTest.minTemp)
        XCTAssertEqual("36°", sunnyWeatherUnderTest.minTemp)
        XCTAssertEqual("5°", rainyWeatherUnderTest.minTemp)
    }

    func testWeatherReturnsExpectedMaxWeatherTemp() {
        XCTAssertEqual("20°", cloudyWeatherUnderTest.maxTemp)
        XCTAssertEqual("30°", sunnyWeatherUnderTest.maxTemp)
        XCTAssertEqual("-2°", rainyWeatherUnderTest.maxTemp)
    }
}

fileprivate extension UIColor {
    static let sunny = UIColor(displayP3Red: 71/255, green: 171/255, blue: 45/255, alpha: 1)
    static let rainy = UIColor(displayP3Red: 87/255, green: 87/255, blue: 93/255, alpha: 1)
    static let cloudy = UIColor(displayP3Red: 84/255, green: 113/255, blue: 122/255, alpha: 1)
}

fileprivate extension UIImage {
    static let sunnyBackground = UIImage(named: "forest_sunny", in: Bundle.main, compatibleWith: nil)
    static let rainyBackground = UIImage(named: "forest_rainy", in: Bundle.main, compatibleWith: nil)
    static let cloudyBackground = UIImage(named: "forest_cloudy", in: Bundle.main, compatibleWith: nil)
    static let sunnyIcon = UIImage(named: "sunny_icon", in: Bundle.main, compatibleWith: nil)
    static let rainyIcon = UIImage(named: "rainy_icon", in: Bundle.main, compatibleWith: nil)
    static let cloudyIcon = UIImage(named: "cloudy_icon", in: Bundle.main, compatibleWith: nil)
}
