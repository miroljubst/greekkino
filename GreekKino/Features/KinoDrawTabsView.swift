//
//  KinoDrawTabsView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

struct KinoDrawTabsView: View {
    let draw: KinoDraw
    
    var body: some View {
        TabView {
            KinoDrawSelectView(draw: draw).tabItem {  Label("Talon", systemImage: "square.grid.3x3.square") }
            KinoDrawLiveView().tabItem {  Label("Izvlacenje", systemImage: "play.circle") }
            KinoDrawResultsView().tabItem {  Label("Rezultati", systemImage: "r.circle") }
        }
        .onAppear() {
            let defaultAppearance = UITabBarAppearance()
            defaultAppearance.backgroundColor = UIColor(.black.opacity(0.9))
            UITabBar.appearance().scrollEdgeAppearance = defaultAppearance
            UITabBar.appearance().standardAppearance = defaultAppearance
        }
        .tint(Constants.Colors.primary)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Constants.Colors.secondary)
        .toolbarRole(.editor)
    }
}

#Preview {
    KinoDrawTabsView(draw: KinoDraw(gameId: 1, drawId: 1, drawTime: 1716723600000, status: .active))
}
