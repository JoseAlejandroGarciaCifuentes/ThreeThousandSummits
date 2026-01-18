//
//  SearchPeaksUseCaseTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits

struct SearchPeaksUseCaseTests {

    // MARK: - Properties

    let sut: SearchPeaksUseCaseImpl

    
    // MARK: - Init

    init() {
        self.sut = SearchPeaksUseCaseImpl()
    }
    

    // MARK: - Testing

    @Test
    func returnsAllPeaks_whenQueryIsEmpty() {
        // Given
        let peaks = [
            Peak(id: 1,
                 name: "Aneto",
                 elevation: 3404,
                 coordinate: .init(latitude: 42.631, longitude: 0.656),
                 lang: "es",
                 wikiName: "Aneto"),
            Peak(id: 2,
                 name: "Posets",
                 elevation: 3328,
                 coordinate: .init(latitude: 42.6498, longitude: 0.4265),
                 lang: "es",
                 wikiName: "Posets")
        ]

        // When
        let result = sut.execute(peaks: peaks, query: "")

        // Then
        #expect(result == peaks)
    }

    @Test
    func filtersPeaksByName_caseInsensitive() {
        // Given
        let peaks = [
            Peak(id: 1,
                 name: "Aneto",
                 elevation: 3404,
                 coordinate: .init(latitude: 42.631, longitude: 0.656),
                 lang: "es",
                 wikiName: "Aneto"),
            Peak(id: 2,
                 name: "Posets",
                 elevation: 3328,
                 coordinate: .init(latitude: 42.6498, longitude: 0.4265),
                 lang: "es",
                 wikiName: "Posets")
        ]

        // When
        let result = sut.execute(peaks: peaks, query: "ane")

        // Then
        #expect(result.map(\.name) == ["Aneto"])
    }

    @Test
    func returnsEmptyArray_whenNoPeakMatchesQuery() {
        // Given
        let peaks = [
            Peak(id: 1,
                 name: "Aneto",
                 elevation: 3404,
                 coordinate: .init(latitude: 42.631, longitude: 0.656),
                 lang: "es",
                 wikiName: "Aneto")
        ]

        // When
        let result = sut.execute(peaks: peaks, query: "MontBlanc")

        // Then
        #expect(result.isEmpty)
    }
}
