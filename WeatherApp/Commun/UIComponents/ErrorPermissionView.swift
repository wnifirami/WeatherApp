//
//  ErrorPermissionView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI
import CoreLocation
struct ErrorPermissionView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    let error: String
    
    init(
        viewModel: ViewModel,
     error: String
    ) {
        self.viewModel = viewModel
        self.error = error
    }
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .scaledToFit()
                .foregroundColor(.red)
                .padding()
            Text(error)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
            
            RequestLocationButton(eventController: viewModel)
                .padding()
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .padding()
        .shadow(color: .secondary, radius: 4)
    }
}

struct ErrorPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPermissionView(
            viewModel: ViewModel(
                service: WeatherService(),
                locationManager: CLLocationManager()
            ), error: "This is an error"
        )
    }
}
