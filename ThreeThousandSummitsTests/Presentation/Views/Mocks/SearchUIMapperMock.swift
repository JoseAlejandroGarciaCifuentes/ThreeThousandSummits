//
//  SearchUIMapperMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class SearchUIMapperMock: SearchUIMapper {

    var mappedPeaks: [Peak] = []

    func mapPeakSearchSuggestionUIModel(from peaks: [Peak]) -> [SearchUIModel] {
        mappedPeaks = peaks
        return peaks.map(map)
    }

    func map(_ peak: Peak) -> SearchUIModel {
        SearchUIModel(
            id: peak.id,
            name: peak.name,
            icon: "mountain.2.fill",
            elevation: peak.elevation
        )
    }
}
