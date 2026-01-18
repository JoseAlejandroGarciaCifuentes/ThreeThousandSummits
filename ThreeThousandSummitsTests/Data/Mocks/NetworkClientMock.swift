//
//  NetworkClientMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation
@testable import ThreeThousandSummits

final class NetworkClientMock: NetworkClient {

    var requestResult: Result<Data, Error>?
    private(set) var requestedTarget: NetworkTarget?

    func request(_ target: NetworkTarget) async throws -> Data {
        requestedTarget = target

        guard let requestResult else {
            fatalError("requestResult not set in NetworkClientMock")
        }

        return try requestResult.get()
    }
}
