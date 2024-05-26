//
//  KinoDrawLiveView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI
import WebKit

struct KinoDrawLiveView: View {
    var body: some View {
        WebView(url: URL(string: Constants.Network.liveDrawURL))
    }
}

#Preview {
    KinoDrawLiveView()
}
