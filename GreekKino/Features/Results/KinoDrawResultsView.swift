//
//  KinoDrawResultsView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

struct KinoDrawResultsView: View {
    
    enum SizeConstants {
        static let numberSize = 30.0
    }
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            List(viewModel.results, id: \.drawId) {result in
                VStack {
                    HStack {
                        Text("Vreme izvlacenja: \(result.formattedTime) | Kolo: \(result.drawId)")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.gray.opacity(0.3))
                    LazyVGrid(columns:[GridItem(.adaptive(minimum: SizeConstants.numberSize))]) {
                        ForEach(result.winningNumbers.list, id: \.self) { item in
                            NumberView(number: item)
                            .frame(width: SizeConstants.numberSize,
                                   height: SizeConstants.numberSize)
                        }
                    }
                }
                .listRowBackground(Color.black)
            }
            .listRowInsets(.none)
            .listStyle(.plain)
            .background(.black)
            .refreshable {
                do {
                    try await viewModel.fetchKinoResults()
                } catch let error {
                    print(error)
                }
            }
        }
        .task {
            do {
                try await viewModel.fetchKinoResults()
            } catch let error {
                print(error)
            }
        }
    }
}

#Preview {
    KinoDrawResultsView()
}
