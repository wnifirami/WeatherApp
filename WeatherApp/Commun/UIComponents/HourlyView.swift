//
//  DayView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI

struct HourView: View {
    // MARK: - Properties
    let hourData: Currently
    init(hourData: Currently) {
        self.hourData = hourData
    }
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(hourData.time.dateFromTimestamp(formatter: "HH:mm"))
                    .font(.caption2)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
                DownloadableImage(
                    imageUrl: EndPoint.createImageUrl(imageName: hourData.icon)
                )
                .frame(width: 25, height: 25, alignment: .center)
                    .padding(.all, 5)
                VStack(alignment: .leading) {                    
                    Text(hourData.temperature.calculateCelsius())
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }

        }
        .padding()

    }
}
