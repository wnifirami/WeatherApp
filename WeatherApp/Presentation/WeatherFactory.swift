//
//  WeatherFactory.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation
import CoreLocation
protocol WeatherManufactoring {
    static func configureWeatherView() -> WeatherView
}

final class WeatehrFactory: WeatherManufactoring {
    
    public static func configureWeatherView() -> WeatherView {
        let servcie = WeatherService()
        let locationManager = CLLocationManager()
        let viewModel = ViewModel(
            service: servcie,
            locationManager: locationManager
        )
        let weatherView = WeatherView(
            viewModel: viewModel
        )
        return weatherView
    }
}

