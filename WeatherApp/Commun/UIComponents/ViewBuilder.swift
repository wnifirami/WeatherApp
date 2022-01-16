//
//  AlignViewBuilder.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//
import SwiftUI

struct AlignViewsBuilder: View {
    let iconName: String
    let title: String
    let description: String
    init(title: String = "",
         description: String = "",
         iconName: String = ""
    ) {
        self.title = title
        self.description = description
        self.iconName = iconName
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: iconName)
                    .font(.footnote)
                    .foregroundColor(.primary)
                    .padding(.all, 5)
                    .background(
                        Circle()
                            .fill(Color.secondary.opacity(0.4))
                            .shadow(color: .secondary, radius: 1, x: 0, y: 2)
                    )
                
                Text(title)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
            Text(description)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding(.all, 5)
    }
}

struct DayViewsBuilder: View {
    let iconName: String
    let description: String
    init(
        description: String = "",
        iconName: String = ""
    ) {
        self.description = description
        self.iconName = iconName
    }
    var body: some View {
        
        VStack {
            Image(systemName: iconName)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.all, 5)
                .background(
                    Circle()
                        .fill(Color.secondary.opacity(0.4))
                        .shadow(color: .secondary, radius: 1, x: 0, y: 2)
                )
            
            Text(description)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.primary)
        }
    }
}

struct SectionTitleViewBuilder<Content: View>: View {
    let content: Content
    let iconName: String
    let description: String
    init(
        iconName: String = "",
        description: String,
        @ViewBuilder content: () -> Content) {
        self.iconName = iconName
        self.description = description
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 5) {
                if !iconName.isEmpty {
                    Image(systemName: iconName)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .padding()
            Divider()
            content
        }
        .addRectangledShadow()
    }
}


