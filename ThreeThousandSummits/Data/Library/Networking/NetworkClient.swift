//
//  NetworkClient.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Foundation

protocol NetworkClient {
    func request(_ target: NetworkTarget) async throws -> Data
}

final class NetworkClientImpl: NetworkClient {

    func request(_ target: NetworkTarget) async throws -> Data {
        let request = try target.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
