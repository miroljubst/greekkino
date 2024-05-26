//
//  KinoDrawResultsView+ViewModel.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import Foundation

extension KinoDrawResultsView {

    class ViewModel:ObservableObject {
        
        @Published var results: [KinoDrawResult] = [KinoDrawResult]()
        @Published var selectedNumbers: Set<Int> = []

        private let networkClient: NetworkClient
        private var fetchTask: Task<Void, Error>?
        
        init(networkClient: NetworkClient = NetworkClient()) {
            self.networkClient = networkClient
        }
        
        func fetchKinoResults() async throws -> Void {
            var urlString = Constants.Network.getDrawResultsURL
            urlString = urlString.replacingOccurrences(of: "{gameId}", with: "1100")
            urlString = urlString.replacingOccurrences(of: "{fromDate}", with: self.todayDateString())
            urlString = urlString.replacingOccurrences(of: "{toDate}", with: self.todayDateString())
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }

            fetchTask?.cancel()
            fetchTask = Task {
                if let model: KinoDrawResults = try await self.networkClient.data(url) {
                    await MainActor.run {
                        self.results = model.content
                    }
                }
            }
        }
        
        private func todayDateString() -> String {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            return dateFormatter.string(from: date)
        }
        
        deinit {
            fetchTask?.cancel()
        }
    }
}
