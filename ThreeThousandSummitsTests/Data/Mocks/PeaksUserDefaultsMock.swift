//
//  PeaksUserDefaultsMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class PeaksUserDefaultsMock: PeaksUserDefaults, @unchecked Sendable {

    private var storedPeaks: [Peak]?

    func getPeaks() -> [Peak]? {
        storedPeaks
    }

    func setPeaks(_ peaks: [Peak]) {
        storedPeaks = peaks
    }
}
