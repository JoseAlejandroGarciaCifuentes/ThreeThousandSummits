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
            Peak(id: 1,
                 name: "Aneto",
                 elevation: 3404,
                 coordinate: .init(latitude: 1.0, longitude: 1.0),
                 lang: "es",
                 wikiName: "Aneto")
        ]

        await peakLocalProvider.set(peaks: cachedPeaks)

        // When
        let result = try await sut.getPeaks(forceUpdate: false)

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
            Peak(id: 1,
                 name: "Posets",
                 elevation: 3328,
                 coordinate: .init(latitude: 1.0, longitude: 1.0),
                 lang: "es",
                 wikiName: "Posets")
        ]

        peakDataMapper.peaksResult = peaks

        // When
        let result = try await sut.getPeaks(forceUpdate: true)

        // Then
        #expect(result == peaks)
        #expect(peakDataMapper.mapPeaksCalled)
        #expect(networkClient.requestedTarget != nil)

        let cached = await peakLocalProvider.getPeaks()
        #expect(cached == peaks)
    }
    
    @Test
    func getPeakInfo_returnsCachedInfo_whenCacheExists() async throws {
        // Given
        let peak = Peak(id: 1,
                        name: "Pic Long",
                        elevation: 3192,
                        coordinate: .init(latitude: 42.8008, longitude: 0.1001),
                        lang: "en",
                        wikiName: "Pic_Long")

        let cachedInfo = await PeakInfo(id: peak.id,
                                        title: "Pic Long",
                                        description: "Peak in the Pyrenees",
                                        imageURL: "https://example.com/piclong.jpg")

        let cacheKey = await peak.wikipediaCacheKey!
        await peakInfoLocalProvider.setPeakInfo(cachedInfo, for: cacheKey)

        // When
        let result = try await sut.getPeakInfo(for: peak)

        // Then
        #expect(result == cachedInfo)
    }

    @Test
    func getPeakInfo_requestsRemoteAndCaches_whenNoCache() async throws {
        // Given
        let peak = Peak(id: 1,
                        name: "Pic Long",
                        elevation: 3192,
                        coordinate: .init(latitude: 42.8008, longitude: 0.1001),
                        lang: "en",
                        wikiName: "Pic_Long")

        let data = """
        {
          "query": {
            "pages": {
              "123": {
                "pageid": 123,
                "title": "Pic Long",
                "extract": "Peak in the Pyrenees",
                "original": {
                  "source": "https://example.com/piclong.jpg",
                  "width": 800,
                  "height": 600
                }
              }
            }
          }
        }
        """.data(using: .utf8)!

        networkClient.requestResult = .success(data)

        let peakInfo = await PeakInfo(
            id: peak.id,
            title: "Pic Long",
            description: "Peak in the Pyrenees",
            imageURL: "https://example.com/piclong.jpg"
        )

        peakDataMapper.peakInfoResult = peakInfo

        // When
        let result = try await sut.getPeakInfo(for: peak)

        // Then
        #expect(result == peakInfo)
        #expect(peakDataMapper.mapPeakInfoCalled)
        #expect(networkClient.requestedTarget != nil)

        let cached = await peakInfoLocalProvider.getPeakInfo(for: peak.wikipediaCacheKey!)
        #expect(cached == peakInfo)
    }

    @Test
    func getPeakInfo_returnsNil_whenPeakHasNoWikipediaData() async throws {
        // Given
        let peak = Peak(id: 1,
                        name: "Unknown Peak",
                        elevation: 3000,
                        coordinate: .init(latitude: 0.0, longitude: 0.0),
                        lang: nil,
                        wikiName: nil)

        // When
        let result = try await sut.getPeakInfo(for: peak)

        // Then
        #expect(result == nil)
    }
    
}
