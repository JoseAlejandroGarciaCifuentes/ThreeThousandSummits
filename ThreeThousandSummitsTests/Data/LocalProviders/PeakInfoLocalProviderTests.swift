//
//  PeakInfoLocalProviderTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits

struct PeakInfoLocalProviderTests {

    @Test
    func returnsCachedInfo_whenCacheIsValid() async {
        let sut = await PeakInfoLocalProviderImpl()

        let info = PeakInfo(
            id: 1,
            title: "Pic Long",
            description: "Peak",
            imageURL: nil
        )

        await sut.setPeakInfo(info, for: "key")

        let result = await sut.getPeakInfo(for: "key")

        #expect(result == info)
    }
}
