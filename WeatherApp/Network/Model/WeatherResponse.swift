//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation

// MARK: - WeatherRespense
struct WeatherRespense: Codable {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently
    let hourly: Hourly
    let daily: Daily
    let flags: Flags
    let offset: Int
}

// MARK: - Currently
struct Currently: Codable, Identifiable {
    let id = UUID()
    let time: Int
    let summary: String
    let icon: String
    let  temperature, apparentTemperature: Double
    let  humidity, pressure, windSpeed: Double
    let uvIndex: Int
    let visibility, ozone: Double
}


// MARK: - Daily
struct Daily: Codable {
    let summary: String
    let icon: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id = UUID()
    let time: Int
    let summary: String
    let icon: String
    let sunriseTime, sunsetTime: Int
    let temperatureHigh: Double
    let temperatureLow: Double
    let  humidity, pressure, windSpeed: Double
    let uvIndex: Int
    let visibility, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double

}

// MARK: - Flags
struct Flags: Codable {
    let sources: [String]
    let meteoalarmLicense: String
    let nearestStation: Double
    let units: String

    enum CodingKeys: String, CodingKey {
        case sources
        case meteoalarmLicense = "meteoalarm-license"
        case nearestStation = "nearest-station"
        case units
    }
}

// MARK: - Hourly
struct Hourly: Codable {

    let summary: String
    let icon: String
    let data: [Currently]
}
