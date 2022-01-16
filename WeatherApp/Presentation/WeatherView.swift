//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    var body: some View {
        createView()
            .onAppear(perform: {
                viewModel.getWeather()
            })
    }
    
    @ViewBuilder
    private func createView() -> some View {
        VStack {
            switch viewModel.networkStatus {
            case .satisfied:
                createWeatehrView()
            default:
                ErrorView(
                    error: offlineError,
                    isNetwork: true
                    )
            }
        }
    }
    
    
    @ViewBuilder
    private func createWeatehrView() -> some View {
        VStack {
            switch viewModel.state {
            case .initial, .loading:
                createSpinneView()
            case .success(let data):
                VStack {
                    Text("\(data.timezone)")
                        .animation(.easeIn)
                    DownloadableImage(
                        imageUrl: EndPoint.createImageUrl(imageName: data.currently.icon)
                    ) .background(Color.white)
                        .shadow(color: .secondary, radius: 2)
                        .padding(.all, 5)
                }
            case .fail(let error):
                showErrorView(error: error.localizedDescription, isNetwork: false)
            }
        }
    }
    
    @ViewBuilder
    private func createSpinneView() -> some View {
        Spinner(isAnimating: true, style: .large)
            .eraseToAnyView()
    }
    
    @ViewBuilder
    private func showErrorView(
        error: String,
        isNetwork: Bool
    ) -> some View {
        ErrorView(
            error: error,
            isNetwork: isNetwork
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(
            viewModel: ViewModel(
                service: WeatherService()
            )
        )
    }
}
