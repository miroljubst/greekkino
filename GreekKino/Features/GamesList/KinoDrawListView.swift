//
//  KinoDrawsView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 25.5.24..
//

import SwiftUI

struct KinoDrawListView: View {

    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                KinoHeader()
                List(viewModel.drawList, id: \.drawId) { draw in
                    NavigationLink(value: draw) {
                        HStack{
                            Text("\(draw.formattedTime)")
                                .foregroundStyle(.gray)
                            Spacer()
                            Text("\(draw.remainingTime)")
                                .foregroundStyle((draw.status == .active) ? .red : .gray)
                        }
                        .alignmentGuide(.listRowSeparatorLeading) {d in
                            d[.leading] - 20
                        }                        
                    }
                    .listRowBackground(Color.black)
                    .listRowSeparatorTint(.gray)
                }
                .background(.black)
                .listStyle(.plain)
                .task {
                    loadData()
                }
                .refreshable {
                    loadData()
                }
                .navigationDestination(for: KinoDraw.self) { draw in
                    KinoDrawTabsView(draw: draw)
                }
            }
        }
        .tint(Constants.Colors.primary)
        .alert(isPresented: $viewModel.presentErrorAlert){
            Alert(title: Text("Doslo je do greske"),
                  dismissButton: Alert.Button.default(
                    Text("U redu"),
                    action: {
                        viewModel.resetError()
                    }
            ))
        }
    }
    
    private func loadData() {
        Task {
            do {
                try await viewModel.fetchUpcomingDrawList()
            } catch let error {
                viewModel.error = error
                viewModel.presentErrorAlert = true
            }
        }
    }
}

struct KinoHeader: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Text("GRCKI KINO")
                    .font(.headline)
                    .foregroundStyle(Constants.Colors.primary)
                Spacer()
            }
            .padding()
            .background(Constants.Colors.secondary)
            Divider()
            HStack {
                Text("Vreme izvlacenja")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                Spacer()
                Text("Preostalo za uplatu")
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            .padding()
            .background(Constants.Colors.secondary)
        }
    }
}

#Preview {
    KinoDrawListView()
}
