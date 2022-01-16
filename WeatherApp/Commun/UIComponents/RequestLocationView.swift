//
//  RequestLocationView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI

struct RequestLocationView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            RequestLocationButton(eventController: viewModel)
            Text("We need your permission to track you.")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding()
        .addRectangledShadow()
        
    }
}
