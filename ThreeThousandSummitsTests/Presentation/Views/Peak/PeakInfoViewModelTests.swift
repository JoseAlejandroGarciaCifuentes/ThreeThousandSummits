//
//  PeakInfoViewModelTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
import Combine
@testable import ThreeThousandSummits

struct PeakInfoViewModelTests {

    // MARK: - Properties

    let getPeakInfoUseCase: GetPeakInfoUseCaseMock
    let peakUIMapper: PeakUIMapperMock
    let sut: PeakInfoView.ViewModel

    
    // MARK: - Init

    init() {
        self.getPeakInfoUseCase = GetPeakInfoUseCaseMock()
        self.peakUIMapper = PeakUIMapperMock()

        self.sut = PeakInfoView.ViewModel(getPeakInfoUseCase: getPeakInfoUseCase,
                                          peakUIMapper: peakUIMapper)
    }

    
    // MARK: - Tests

    @Test
    func loadsPeakInfoSuccessfully_whenSetupIsCalled() async {
        // Given
        let peak = Peak(id: 1,
                        name: "Pic Long",
                        elevation: 3192,
                        coordinate: .init(latitude: 42.8, longitude: 0.1),
                        lang: "en",
                        wikiName: "Pic_Long")

        let peakInfo = PeakInfo(id: 1,
                                title: "Pic Long",
                                description: "Peak in the Pyrenees",
                                imageURL: nil)

        getPeakInfoUseCase.result = .success(peakInfo)

        // When
        await sut.setup(peak: peak)
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(sut.peakInfoUIModel != nil)
        #expect(peakUIMapper.mappedPeak?.id == peak.id)
        #expect(peakUIMapper.mappedPeakInfo?.id == peakInfo.id)
    }

    @Test
    func doesNothing_whenSetupReceivesNilPeak() async {
        // When
        await sut.setup(peak: nil)
        try? await Task.sleep(nanoseconds: 50_000_000)

        // Then
        #expect(sut.peakInfoUIModel == nil)
    }

    @Test
    func onlyLastSetupUpdatesUIModel_whenPreviousTaskIsCancelled() async {
        // Given
        let peak = Peak(id: 1,
                        name: "Pic Long",
                        elevation: 3192,
                        coordinate: .init(latitude: 42.8, longitude: 0.1),
                        lang: "en",
                        wikiName: "Pic_Long")

        let peakInfo = PeakInfo(id: 1,
                                title: "Pic Long",
                                description: "Peak in the Pyrenees",
                                imageURL: nil)

        getPeakInfoUseCase.result = .success(peakInfo)

        // When
        await sut.setup(peak: peak)
        await sut.setup(peak: peak) // cancels previous task
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(sut.peakInfoUIModel != nil)
        await #expect(sut.peakInfoUIModel?.name == peak.name)
    }
}
