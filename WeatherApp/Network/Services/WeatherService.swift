//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation
import Combine

protocol WeatherServiceProtocol: AnyObject {
    func getWeatherInfo() -> AnyPublisher<WeatherRespense, Error>
}

class WeatherService: WeatherServiceProtocol {
      func getWeatherInfo() -> AnyPublisher<WeatherRespense, Error> {
        guard let url = URL(
            string: EndPoint.baseUrl + "/59.337239,18.062381"
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

