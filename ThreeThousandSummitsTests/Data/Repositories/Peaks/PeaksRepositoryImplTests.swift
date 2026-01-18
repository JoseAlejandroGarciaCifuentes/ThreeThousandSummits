//
//  PeaksRepositoryImplTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits
import Foundation

struct PeaksRepositoryImplTests {

    // MARK: - Properties

    let networkClient: NetworkClientMock
    let peakDataMapper: PeakDataMapperMock
    let peakLocalProvider: PeakLocalProviderMock
    let peakInfoLocalProvider: PeakInfoLocalProviderMock

    let sut: PeaksRepositoryImpl

    // MARK: - Init

    init() {
        self.networkClient = NetworkClientMock()
        self.peakDataMapper = PeakDataMapperMock()
        self.peakLocalProvider = PeakLocalProviderMock()
        self.peakInfoLocalProvider = PeakInfoLocalProviderMock()

        self.sut = PeaksRepositoryImpl(
            networkClient: networkClient,
            peakDataMapper: peakDataMapper,
            peakLocalProvider: peakLocalProvider,
            peakInfoLocalProvider: peakInfoLocalProvider
        )
    }

    // MARK: - Tests

    @Test
    func getPeaks_returnsLocalPeaks_whenCacheExists() async throws {
        // Given
        let cachedPeaks = [
            Peak(id: 1, name: "Aneto", elevation: 3404, coordinate: .init(latitude: 1.0, longitude: 1.0), lang: "es", wikiName: "Aneto")
        ]

        await peakLocalProvider.set(peaks: cachedPeaks)

        // When
        let result = try await sut.getPeaks()

        // Then
        #expect(result == cachedPeaks)
    }

    @Test
    func getPeaks_requestsRemoteAndCaches_whenNoLocalCache() async throws {
        // Given
        let data = """
        {
          "elements": []
        }
        """.data(using: .utf8)!

        networkClient.requestResult = .success(data)

        let peaks = [
            Peak(id: 1, name: "Posets", elevation: 3328, coordinate: .init(latitude: 1.0, longitude: 1.0), lang: "es", wikiName: "Posets")
        ]

        peakDataMapper.peaksResult = peaks

        // When
        let result = try await sut.getPeaks()

        // Then
        #expect(result == peaks)
        #expect(peakDataMapper.mapPeaksCalled)
        #expect(networkClient.requestedTarget != nil)

        let cached = await peakLocalProvider.getPeaks()
        #expect(cached == peaks)
    }
}
