//
//  RequestLocationButton.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI

struct RequestLocationButton: View {
    // MARK: - Properties
    let eventController: PermissionProtocol
    init(eventController: PermissionProtocol) {
        self.eventController = eventController
    }
    // MARK: - Body
    var body: some View {
        Button(action: {
            eventController.request()
        }, label: {
            Label(
                "Allow tracking",
                  systemImage: "location"
            )
        })
        .padding(10)
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

