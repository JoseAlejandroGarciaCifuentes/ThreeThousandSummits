//
//  GetPeaksUseCaseTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits

struct GetPeaksUseCaseTests {

    // MARK: - Properties

    let peaksRepository: PeaksRepositoryMock
    let sut: GetPeaksUseCaseImpl

    // MARK: - Init

    init() {
        self.peaksRepository = PeaksRepositoryMock()
        self.sut = GetPeaksUseCaseImpl(peaksRepository: peaksRepository)
    }

    // MARK: - Testing

    @Test
    func receivePeaks() async throws {
        // Given
        let peaks = [
            Peak(id: 1,
                name: "Aneto",
                elevation: 3404,
                coordinate: .init(latitude: 42.631, longitude: 0.656),
                lang: "es",
                wikiName: "Aneto")
        ]

        peaksRepository.getPeaksResult = .success(peaks)

        // When
        let result = try await sut.execute(forceUpdate: true)

        // Then
        #expect(peaksRepository.getPeaksCalled)
        #expect(result == peaks)
    }
}
