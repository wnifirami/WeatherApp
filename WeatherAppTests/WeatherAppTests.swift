//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Rami Ounifi on 15/1/2022.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUp()  {
    }

    override func tearDown()  {
    }

    func testFullDate() throws {
        let timeStamp = 1642333367
        let expression = timeStamp.dateFromTimestamp(
            formatter: StringConstants.fullDateFormatter
        )
        XCTAssertEqual(expression, "Jan, 16 2022")
    }
    
    func testTime() throws {
        let timeStamp = 1642333367
        let expression = timeStamp.dateFromTimestamp(
            formatter: "HH:mm"
        )
        XCTAssertNotEqual(expression, "00:00")
    }

    func testDegree() {
        let fahrenheitDegree = 58.83
        let cellciusDegree = fahrenheitDegree.calculateCelsius()
        XCTAssertEqual(cellciusDegree, "14°C")
        XCTAssertNotEqual(cellciusDegree, "7°C")
    }
    
    func testClearTimeZone() {
        let text = "Hello / Test"
        let expression = text.getClearTimeZone()
        XCTAssertEqual(expression, "Hello , Test")
    }
}
