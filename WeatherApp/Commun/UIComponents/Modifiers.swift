//
//  Modifiers.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 16/1/2022.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(UIColor.systemBackground).cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
                    .shadow(color: .secondary, radius: 1)
            )
    }
}


extension View {
    func addRectangledShadow()  -> some View {
        self
            .modifier(ShadowModifier())
    }
}

