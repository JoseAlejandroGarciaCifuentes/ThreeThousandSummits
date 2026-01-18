//
//  PeaksRepositoryMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class PeaksRepositoryMock: PeaksRepository {

    // MARK: - Control

    var getPeaksResult: Result<[Peak], Error>?
    var getPeakInfoResult: Result<PeakInfo?, Error>?

    private(set) var getPeaksCalled = false
    private(set) var getPeakInfoCalledWith: Peak?

    // MARK: - Implementation

    func getPeaks(forceUpdate: Bool) async throws -> [Peak] {
        getPeaksCalled = true

        guard let getPeaksResult else {
            fatalError("getPeaksResult not set in PeaksRepositoryMock")
        }

        return try getPeaksResult.get()
    }

    func getPeakInfo(for peak: Peak) async throws -> PeakInfo? {
        getPeakInfoCalledWith = peak

        guard let getPeakInfoResult else {
            fatalError("getPeakInfoResult not set in PeaksRepositoryMock")
        }

        return try getPeakInfoResult.get()
    }
}
