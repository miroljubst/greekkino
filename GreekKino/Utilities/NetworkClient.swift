//
//  NetworkClient.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 25.5.24..
//

import Foundation

class NetworkClient: NetworkService {

    let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func data<T>(_ url: URL) async throws -> T where T : Decodable {
        let (data,_) = try await self.session.data(from: url)
        let model = try JSONDecoder().decode(T.self, from: data)
        return model
    }
}

protocol NetworkService {
    func data<T: Decodable>(_ url: URL) async throws -> T
}
