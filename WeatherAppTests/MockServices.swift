//
//  MockServices.swift
//  WeatherAppTests
//
//  Created by Rami Ounifi on 17/1/2022.
//

import Foundation
import Combine
import CoreLocation
@testable import WeatherApp

class MockService: WeatherServiceProtocol {
     func getWeatherInfo(coordinates: CLLocationCoordinate2D) -> AnyPublisher<WeatherRespense, Error>{
                    return Future<WeatherRespense, Error> { promise in
                        promise(.failure(FetchError.failed))
        }.eraseToAnyPublisher()
    }
}
