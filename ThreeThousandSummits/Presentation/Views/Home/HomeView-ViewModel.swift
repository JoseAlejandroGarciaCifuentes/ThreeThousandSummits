//
//  HomeView-ViewModel.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Foundation
import Combine

extension HomeView {
    final class ViewModel: BaseViewModel {
        
        // MARK: - Dependencies
        
        // UseCases
        private let getPeaksUseCase: GetPeaksUseCase
        private let searchPeaksUseCase: SearchPeaksUseCase
        
        // UIMappers
        private let peakUIMapper: PeakUIMapper
        private let searchUIMapper: SearchUIMapper
        
        
        // MARK: - Init
        
        init(getPeaksUseCase: GetPeaksUseCase,
             searchPeaksUseCase: SearchPeaksUseCase,
             peakUIMapper: PeakUIMapper,
             searchUIMapper: SearchUIMapper) {
            self.getPeaksUseCase = getPeaksUseCase
            self.searchPeaksUseCase = searchPeaksUseCase
            
            self.peakUIMapper = peakUIMapper
            self.searchUIMapper = searchUIMapper
        }
        
        
        // MARK: - Public Properties
        
        @Published var peaks: [Peak] = []
        @Published var selectedPeak: Peak?
        @Published var navigationPath: [Route] = []
        
        @Published var searchSelectedId: Int?
        
        @Published var showErrorAlert: Bool = false
        
        private(set) var peakForNavigation: Peak?
        
        private(set) var searchViewUIModel: SearchView.UIModel = .init(textFieldPlaceholder: "Find Peak…")
        
        // Publishers
        let detailNavigationSubject = PassthroughSubject<Int, Never>()
        
        // Task
        private var getPeaksTask: Task<Void, Error>?
    
        
        // MARK: - LifeCycle
        
        override func onAppear() {
            handleEvents()
            getPeaks()
        }
        
        @MainActor
        deinit {
            getPeaksTask?.cancel()
        }
        
        
        // MARK: - Public Methods
        
        func getPeaks(forceUpdate: Bool = false) {
            getPeaksTask?.cancel()
            
            getPeaksTask = Task(loadable: self) {
                do {
                    let peaks = try await getPeaksUseCase.execute(forceUpdate: forceUpdate)
                    try Task.checkCancellation()
                    
                    await MainActor.run {
                        self.peaks = peaks
                    }
                } catch is CancellationError {
                } catch {
                    await MainActor.run {
                        self.showErrorAlert = true
                    }
                }
            }
        }
        
        func getPeakDetailViewUIModel(from peak: Peak) -> PeakDetailView.UIModel {
            return peakUIMapper.mapPeakDetailUIModel(from: peak, detailNavigationSubject: detailNavigationSubject)
        }
        
        
        // MARK: - Private Methods
        
        private func handleEvents() {
            searchViewUIModel.$searchText
                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                .removeDuplicates()
                .receive(on: RunLoop.main)
                .sink { [weak self] text in
                    guard let self else { return }
                    updateSearch(with: text)
                }
                .store(in: &disposables)
            
            $searchSelectedId
                .receive(on: RunLoop.main)
                .sink { [weak self] id in
                    guard let self else { return }
                    selectedPeak = peaks.first { $0.id == id }
                }
                .store(in: &disposables)
            
            detailNavigationSubject
                .receive(on: RunLoop.main)
                .sink { [weak self] peakId in
                    guard let self else { return }
                    let peak = peaks.first { $0.id == peakId }
                    peakForNavigation = peak
                    reset()
                    DispatchQueue.main.async {
                        self.navigationPath.append(.info)
                    }
                }
                .store(in: &disposables)
            
        }
        
        private func updateSearch(with text: String) {
            let filteredPeaks = searchPeaksUseCase.execute(peaks: peaks, query: text)
            searchViewUIModel.filteredSuggestionUIModel = searchUIMapper.mapPeakSearchSuggestionUIModel(from: filteredPeaks)
        }
        
        private func reset() {
            selectedPeak = nil
            searchSelectedId = nil
        }
    }
}


// MARK: - Route Extension

extension HomeView.ViewModel {
    enum Route: Hashable {
        case info
    }
}
