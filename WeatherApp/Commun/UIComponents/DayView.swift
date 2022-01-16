//
//  DayView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI

struct DayView: View {
    // MARK: - Properties
    let dayData: Datum
    init(dayData: Datum) {
        self.dayData = dayData
    }
    // MARK: - Body
    var body: some View {
        
        VStack {
            VStack(spacing: 10) {
                HStack {
                    Text(dayData.time.dateFromTimestamp(formatter: "MMM, d YYYY"))
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(dayData.summary)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text(dayData.time.dateFromTimestamp(formatter: "EEE"))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    DownloadableImage(
                        imageUrl: EndPoint.createImageUrl(imageName: dayData.icon)
                    )
                    .frame(width: 40, height: 40, alignment: .center)
                    .padding(.all, 5)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "thermometer")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Min: \(dayData.temperatureLow.calculateCelsius())")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("-")
                        Text("Max: \(dayData.temperatureHigh.calculateCelsius())")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                }
                
                
            }
            
            HStack(spacing: 15) {
                DayViewsBuilder(description:"\(Int(dayData.windSpeed)) Km/h" , iconName: "wind")
                DayViewsBuilder(description:"\(Int(dayData.visibility)) Km" , iconName: "eye.fill")
                DayViewsBuilder(description: dayData.sunriseTime.dateFromTimestamp(formatter: "HH:mm"), iconName:"sunrise")
                DayViewsBuilder(description: dayData.sunsetTime.dateFromTimestamp(formatter: "HH:mm"), iconName:"sunset")
                DayViewsBuilder(description:"\(Int(dayData.pressure)) mb" , iconName: "gauge")
            }
            .padding(.vertical)
            Divider()
            
        }
    }
}
