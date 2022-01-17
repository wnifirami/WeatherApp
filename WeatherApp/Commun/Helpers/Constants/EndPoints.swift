//
//  EndPoints.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation
enum EndPoint {
    static let baseUrl: String =  "https://api.darksky.net/forecast/"
        .appending((String(describing: Bundle.valueForAPIKey(named: StringConstants.apiKey))))
    static let imagePlaceholder: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4z_N_tl0P5z3OdnC5q70eP-XDa_SlPW9ODw&usqp=CAU"
    static let imageUrl: String =  "https://darksky.net/images/weather-icons/"
}

extension EndPoint {
    
    static func createImageUrl(
        imageName: String
    ) -> String {

        return imageUrl
        + imageName
        + ".png"
    }
}

enum FetchError: Error {
    case failed
    case timeout
}

let offlineError = "Ooops! we lost internet connection"

