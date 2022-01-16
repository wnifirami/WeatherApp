//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatehrFactory.configureWeatherView()
        }
    }
}
