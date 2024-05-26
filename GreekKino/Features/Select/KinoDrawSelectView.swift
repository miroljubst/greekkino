//
//  KinoDrawSelectView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

struct KinoDrawSelectView: View {
    
    @StateObject var viewModel:ViewModel
    @State var remainingTime: Double
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(draw: KinoDraw) {
        _viewModel = StateObject(wrappedValue: ViewModel(draw: draw))
        remainingTime = draw.remainingSeconds
    }
    
    enum SizeConstants {
        static let numberSize = 30.0
    }
    
    var columns:[GridItem] {
        var items = [GridItem]()
        for _ in  1...10 {
            items.append(GridItem(.flexible()))
        }
        return items
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Text("Kolo: \(viewModel.draw.drawId)")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    Spacer()
                    Text("Ostalo jos: \(secondsToFormattedString(seconds: remainingTime))")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                HStack {
                    Text("Izabrano \(viewModel.selectedNumbers.count)")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                LazyVGrid(columns:columns, spacing: 2) {
                    ForEach(1...80, id: \.self) { item in
                        SelectableNumberView<ViewModel>(number: item)
                            .environmentObject(viewModel)
                        .frame(width: proxy.size.width/11,
                               height: proxy.size.width/11)
                    }
                }
                .padding(.leading,2)
                .padding(.trailing,2)
                Spacer()
            }
            .alert(isPresented: $viewModel.limitReached) {
                Alert(title: Text("Izabrali ste maksimalan broj brojeva"))
            }
            .background(.black)
        }
        .onReceive(timer) { time in
            if remainingTime > 0 {
                remainingTime -= 1
            }
        }
    }
    
    func secondsToFormattedString(seconds: Double) -> String {
      let (hr,  minf) = modf(seconds / 3600)
      let (min, secf) = modf(60 * minf)
        return "\(String(format: "%02d", Int(hr))):\( String(format: "%02d", Int(min))):\(String(format: "%02d", Int(60 * secf)))"
    }

}

#Preview {
    KinoDrawSelectView(draw: KinoDraw(gameId: 11, drawId: 11, drawTime: 11, status: .active))
}

