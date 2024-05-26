//
//  KinoDrawListView+ViewModel.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

extension KinoDrawListView {

    class ViewModel:ObservableObject {
        
        @Published var drawList = [KinoDraw]()
        @Published var error: Error?
        @Published var presentErrorAlert: Bool = false
        
        private var networkClient: NetworkClient
        private var fetchTask: Task<Void, Error>?
        
        init(networkClient: NetworkClient = NetworkClient()) {
            self.networkClient = networkClient
        }
        
        func fetchUpcomingDrawList() async throws -> Void {
            guard let url = URL(string: Constants.Network.getUpcomingDrawListURL) else {
                throw URLError(.badURL)
            }
            fetchTask?.cancel()
            fetchTask = Task {
                if let model: [KinoDraw] = try await self.networkClient.data(url) {
                    await MainActor.run {
                        drawList = model
                    }
                }
            }
        }
        
        func resetError() {
            error = nil
            presentErrorAlert = false
        }
        
        deinit {
            fetchTask?.cancel()
        }
    }
}
