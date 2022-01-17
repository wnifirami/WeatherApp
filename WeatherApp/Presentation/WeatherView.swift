//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import SwiftUI
import CoreLocation
struct WeatherView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    // MARK: - Initializer
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    // MARK: - Body
    var body: some View {
        createView()
            .onAppear(perform: {
                viewModel.getWeather()
            })
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    private func createView() -> some View {
        VStack {
            switch viewModel.networkStatus {
            case .satisfied:
                checkingLocation()
            default:
                ErrorView(
                    error: offlineError,
                    isNetwork: true
                    )
            }
        }
    }
    
    @ViewBuilder
    private func checkingLocation() -> some View {
        switch viewModel.authorizationStatus {
        case .notDetermined:
          RequestLocationView(viewModel: viewModel)
        case .restricted:
            ErrorPermissionView(
                viewModel: viewModel,
                error: StringConstants.restrictedError
            )
        case .denied:
            ErrorPermissionView(
                viewModel: viewModel,
                error: StringConstants.deniedError
            )
        case .authorizedAlways, .authorizedWhenInUse:
            createWeatehrView()
                .onLoad(perform: {
                    viewModel.getWeather()
                })
        default:
            Text("Unexpected status")
        }
    }
    

    
    @ViewBuilder
    private func createWeatehrView() -> some View {
        VStack {
            switch viewModel.state {
            case .initial, .loading:
                createSpinneView()
            case .success(let data):
                createWeatehrView(from: data)
            case .fail(let error):
                showErrorView(error: error.localizedDescription, isNetwork: false)
            }
        }
    }
    
    @ViewBuilder
    private func createWeatehrView(from data: WeatherRespense) -> some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                Text(data.timezone.getClearTimeZone())
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .accessibilityIdentifier("title")
                HStack {
                    Spacer()
                 Image(systemName: "calendar")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    Text(data.currently.time.dateFromTimestamp(
                            formatter: StringConstants.fullDateFormatter
                    ))
                  .font(.footnote)
                   .fontWeight(.bold)
                }  .padding(.horizontal)

                createWeatehrHeaderView(currentDay: data.currently)
                createHourlyView(hourly: data.hourly)
                createDayView(from: data.daily)
            }
            .padding()
        }
    }
    
    
    @ViewBuilder
    private func createDayView(from data: Daily) -> some View {
        SectionTitleViewBuilder(
            iconName: "calendar",
            description: StringConstants.dayTitle
        ) {
            ScrollView(.vertical, showsIndicators: false, content: {
                    ForEach(data.data) { item in
                       DayView(dayData: item)
                        .padding(.horizontal)
                    }
                })
            }
        }
    
    @ViewBuilder
    private func createWeatehrHeaderView(currentDay: Currently) -> some View {
        WeatherHeader(currentDay: currentDay)
       
    }
    
    @ViewBuilder
    private func createHourlyView(hourly: Hourly) -> some View {
        SectionTitleViewBuilder(description: StringConstants.hourTitle) {
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(alignment: .center, spacing: 5) {
                    ForEach(hourly.data) { item in
                       HourView(hourData: item)
                    }
                }
            })
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
                service: WeatherService(), locationManager: CLLocationManager()
            )
        )
    }
}
