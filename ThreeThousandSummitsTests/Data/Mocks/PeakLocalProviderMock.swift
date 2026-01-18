//
//  PeakLocalProviderMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final actor PeakLocalProviderMock: PeakLocalProvider {

    var storedPeaks: [Peak]?
    private(set) var setCalled = false

    func getPeaks() async -> [Peak]? {
        storedPeaks
    }

    func set(peaks: [Peak]) async {
        setCalled = true
        storedPeaks = peaks
    }
}
