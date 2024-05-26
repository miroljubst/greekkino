//
//  WebView.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsLinkPreview = true
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let url else {return}
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
