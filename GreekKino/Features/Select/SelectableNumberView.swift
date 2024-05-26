//
//  SelectableNumberView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

struct SelectableNumberView<T: SelectedNumbers>: View {
    let number: Int
    @State var selected: Bool = false
    @EnvironmentObject var viewModel: T
    
    var color: Color {
        Helpers.colorFor(number: number)
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if selected {
                    Image(systemName: "circle")
                        .resizable(resizingMode: .tile)
                        .foregroundStyle(color)
                }
                Text("\(number)")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .onTapGesture(perform: {
                        selected = viewModel.update(number: number)
                    })
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}
