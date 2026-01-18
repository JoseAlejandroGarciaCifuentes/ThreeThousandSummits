//
//  PeakDataMapperMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class PeakDataMapperMock: PeakDataMapper {

    var peaksResult: [Peak] = []
    var peakInfoResult: PeakInfo?

    private(set) var mapPeaksCalled = false
    private(set) var mapPeakInfoCalled = false

    func mapPeaks(from dto: OverpassDTO) -> [Peak] {
        mapPeaksCalled = true
        return peaksResult
    }

    func mapPeakInfo(from dto: WikipediaDTO) -> PeakInfo? {
        mapPeakInfoCalled = true
        return peakInfoResult
    }
}
