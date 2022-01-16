//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    let isNetwork: Bool
    
    init(
        error: String,
        isNetwork: Bool
    ) {
        self.error = error
        self.isNetwork = isNetwork
    }
    var body: some View {
        VStack {
            Image(systemName: isNetwork ? "xmark.icloud.fill" : "xmark.circle.fill")
                .resizable()
                .frame(width: 120, height: 80, alignment: .center)
                .scaledToFit()
                .foregroundColor(.red)
                .padding()
            Text(error)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
        }
        
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .padding()
        .shadow(color: .secondary, radius: 4)
    }
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "The data can't be read because of bad url", isNetwork: true)
    }
}
