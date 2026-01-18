//
//  PeakLocalProviderTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits

struct PeakLocalProviderTests {

    @Test
    func returnsStoredPeaks_whenPeaksWerePreviouslySaved() async {
        let peaksUserDefaults = PeaksUserDefaultsMock()
        let sut = await PeakLocalProviderImpl(peaksUserDefaults: peaksUserDefaults)

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

        await sut.set(peaks: peaks)

        let result = await sut.getPeaks()

        #expect(result == peaks)
    }
}
