//
//  PeakUIMapperMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits
import Foundation
import Combine

final class PeakUIMapperMock: PeakUIMapper {

    // MARK: - Tracking (opcional para asserts)

    var mappedPeak: Peak?
    var mappedPeakInfo: PeakInfo?

    // MARK: - PeakInfo

    func mapPeakInfoUIModel(from peakInfo: PeakInfo?, and peak: Peak) -> PeakInfoUIModel? {
        mappedPeak = peak
        mappedPeakInfo = peakInfo

        let imageURL = peakInfo?.imageURL
            .flatMap { URL(string: $0.trimmingCharacters(in: .whitespacesAndNewlines)) }

        return PeakInfoUIModel(
            name: peak.name,
            elevation: peak.elevation,
            description: peakInfo?.description,
            imageUrl: imageURL
        )
    }

    // MARK: - PeakDetail

    func mapPeakDetailUIModel(
        from peak: Peak,
        detailNavigationSubject: PassthroughSubject<Int, Never>
    ) -> PeakDetailView.UIModel {

        let formattedCoordinates = String(
            format: "%.4f, %.4f",
            peak.coordinate.latitude,
            peak.coordinate.longitude
        )

        return PeakDetailView.UIModel(
            id: peak.id,
            name: peak.name,
            elevation: peak.elevation,
            coordinates: formattedCoordinates,
            detailNavigationSubject: detailNavigationSubject
        )
    }
}
