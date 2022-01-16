//
//  WeatherHeader.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI

struct WeatherHeader: View {
    // MARK: - Properties
    let currentDay: Currently
    
    init (
        currentDay: Currently
    ) {
        self.currentDay = currentDay
    }
    // MARK: - Body
    var body: some View {
        VStack {

            HStack {
                DownloadableImage(
                    imageUrl: EndPoint.createImageUrl(imageName: currentDay.icon)
                )
                .frame(height: 150, alignment: .center)
                    .padding(.all, 5)
                .shadow(color: .secondary, radius: 2)
                Spacer()
                VStack(alignment: .leading) {
                    Text(currentDay.summary)
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    
                    Text(currentDay.temperature.calculateCelsius())
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            
     
            HStack (spacing: 10){
                VStack {
                    AlignViewsBuilder(title: "Wind", description: "\(Int(currentDay.windSpeed)) Km/h", iconName: "wind")
                    AlignViewsBuilder(title: "Feeling", description: "\(currentDay.apparentTemperature.calculateCelsius())", iconName: "thermometer")
                }
                VStack {
                    AlignViewsBuilder(title: "Visibility", description: "\(Int(currentDay.visibility)) Km", iconName: "eye.fill")
                    AlignViewsBuilder(title: "Feeling", description: "\(currentDay.apparentTemperature.calculateCelsius())", iconName: "thermometer")
                }
                VStack(alignment: .leading, spacing: 5) {
                    AlignViewsBuilder(title: "Humidity", description: "\(Int(currentDay.humidity))%", iconName: "drop.fill")
                    AlignViewsBuilder(title: "UV", description: "\(currentDay.uvIndex)", iconName: "sun.min.fill")
                }
            }
            .padding(.horizontal)              
        }
    }
}


