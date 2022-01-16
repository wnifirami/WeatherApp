//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation
import Combine
import CoreLocation

protocol WeatherServiceProtocol: AnyObject {
    func getWeatherInfo(coordinates: CLLocationCoordinate2D) -> AnyPublisher<WeatherRespense, Error>
}

class WeatherService: WeatherServiceProtocol {
      func getWeatherInfo(coordinates: CLLocationCoordinate2D) -> AnyPublisher<WeatherRespense, Error> {
        guard let url = URL(
            string: EndPoint.baseUrl + "/\(coordinates.latitude),\(coordinates.longitude)"
        ) else {
            return Future<WeatherRespense, Error> { promise in
                promise(.failure(FetchError.failed))
            }.eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: WeatherRespense.self,
                    decoder: JSONDecoder())
            .catch { error in
                Future<WeatherRespense, Error> { promise in
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        return publisher
    }
}

