//
//  NumberView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

struct NumberView: View {
    let number: Int
    var color: Color {
        Helpers.colorFor(number: number)
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(systemName: "circle")
                    .resizable(resizingMode: .tile)
                    .foregroundStyle(color)
                Text("\(number)")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}
