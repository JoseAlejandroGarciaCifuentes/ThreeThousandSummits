//
//  PeakInfoLocalProviderMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final actor PeakInfoLocalProviderMock: PeakInfoLocalProvider {

    var storage: [String: PeakInfo] = [:]
    private(set) var setCalled = false

    func getPeakInfo(for key: String) async -> PeakInfo? {
        storage[key]
    }

    func setPeakInfo(_ info: PeakInfo, for key: String) async {
        setCalled = true
        storage[key] = info
    }
}
