//
//  HomeViewModelTests.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Testing
@testable import ThreeThousandSummits

struct HomeViewModelTests {

    // MARK: - Properties

    let getPeaksUseCase: GetPeaksUseCaseMock
    let searchPeaksUseCase: SearchPeaksUseCaseMock
    let peakUIMapper: PeakUIMapperMock
    let searchUIMapper: SearchUIMapperMock

    let sut: HomeView.ViewModel

    // MARK: - Init

    init() {
        self.getPeaksUseCase = GetPeaksUseCaseMock()
        self.searchPeaksUseCase = SearchPeaksUseCaseMock()
        self.peakUIMapper = PeakUIMapperMock()
        self.searchUIMapper = SearchUIMapperMock()

        self.sut = HomeView.ViewModel(
            getPeaksUseCase: getPeaksUseCase,
            searchPeaksUseCase: searchPeaksUseCase,
            peakUIMapper: peakUIMapper,
            searchUIMapper: searchUIMapper
        )
    }

    // MARK: - Tests

    @Test
    func loadsPeaksSuccessfully_onAppear() async {
        // Given
        let peaks = [
            Peak(id: 1,
                 name: "Aneto",
                 elevation: 3404,
                 coordinate: .init(latitude: 0, longitude: 0),
                 lang: "es",
                 wikiName: "Aneto")
        ]

        getPeaksUseCase.result = .success(peaks)

        // When
        await sut.onAppear()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(sut.peaks == peaks)
        #expect(sut.showErrorAlert == false)
    }

    @Test
    func showsErrorAlert_whenGetPeaksFails() async {
        // Given
        struct DummyError: Error {}
        getPeaksUseCase.result = .failure(DummyError())

        // When
        await sut.onAppear()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(sut.showErrorAlert == true)
    }
}


