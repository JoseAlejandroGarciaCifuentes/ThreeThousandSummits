//
//  GetPeakInfoUseCaseTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits

struct GetPeakInfoUseCaseTests {

    // MARK: - Properties

    let peaksRepository: PeaksRepositoryMock
    let sut: GetPeakInfoUseCaseImpl

    
    // MARK: - Init

    init() {
        self.peaksRepository = PeaksRepositoryMock()
        self.sut = GetPeakInfoUseCaseImpl(peaksRepository: peaksRepository)
    }

    
    // MARK: - Testing

    @Test
    func receivePeakInfo() async throws {
        // Given
        let peak = Peak(id: 1,
                        name: "Pic Long",
                        elevation: 3192,
                        coordinate: .init(latitude: 42.8008, longitude: 0.1001),
                        lang: "es",
                        wikiName: "Pic Long")

        let peakInfo = PeakInfo(id: 1,
                                title: "Pic Long",
                                description: "Peak in the Pyrenees",
                                imageURL: "https://example.com/piclong.jpg")

        peaksRepository.getPeakInfoResult = .success(peakInfo)

        // When
        let result = try await sut.execute(with: peak)

        // Then
        #expect(peaksRepository.getPeakInfoCalledWith == peak)
        #expect(result == peakInfo)
    }
}
