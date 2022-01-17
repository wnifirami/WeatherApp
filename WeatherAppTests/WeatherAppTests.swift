//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Rami Ounifi on 15/1/2022.
//

import XCTest
import CoreLocation
import Network

@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    var viewModel: ViewModel!
    var services: WeatherServiceProtocol!
    @Published var networkStatus: NWPath.Status = .satisfied
    override func setUp()  {
        services = MockService()
        viewModel = ViewModel(
            service: services,
            locationManager: CLLocationManager()
        )
    }

    override func tearDown()  {
        services = nil
        viewModel = nil
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
    
    func testResponse() {
        viewModel.getWeather()
        // expected result here is .fail(FetchError.failed)
        XCTAssertNotEqual(viewModel.state, .fail(FetchError.timeout))
        XCTAssertFalse(viewModel.state == .initial)
    }
    
    
    func testAuthorizationDenied() {
        viewModel.authorizationStatus = .denied
        XCTAssertEqual(viewModel.lastSeenLocation, nil)
    }
    
    func testAuthorizationRestricted() {
        viewModel.authorizationStatus = .restricted
        XCTAssertEqual(viewModel.lastSeenLocation, nil)
    }
    
    func testNetwork() throws {
        try XCTSkipUnless(
            viewModel.networkStatus == .satisfied,
          "Network connectivity needed for this test.")
    }
    
  
}
