//
//  DownloadableImage.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import SwiftUI

struct DownloadableImage: View {
    @Environment(\.imageCache) var cache: ImageCache
    @State var imageUrl: String
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: imageUrl) ?? URL(string: EndPoint.imagePlaceholder)! ,
                cache: cache,
                placeholder: spinner,
                configuration: { $0.resizable().renderingMode(.original) }
            )
                .scaledToFit()
        }
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}
