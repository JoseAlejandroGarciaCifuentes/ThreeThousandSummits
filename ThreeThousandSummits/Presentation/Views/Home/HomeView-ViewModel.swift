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
        
        // UIMappers
        private let searchUIMapper: SearchUIMapper
        
        
        // MARK: - Init
        
        init(getPeaksUseCase: GetPeaksUseCase,
             searchUIMapper: SearchUIMapper) {
            self.getPeaksUseCase = getPeaksUseCase
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
        let detailNavigationSubject = PassthroughSubject<Peak, Never>()
        
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
                .sink { [weak self] peak in
                    guard let self else { return }
                    peakForNavigation = peak
                    selectedPeak = nil
                    searchSelectedId = nil
                    DispatchQueue.main.async {
                        self.navigationPath.append(.info)
                    }
                }
                .store(in: &disposables)
            
        }
        
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
        
        private func updateSearch(with text: String) {
            guard !text.isEmpty else {
                searchViewUIModel.filteredSuggestionUIModel = searchUIMapper.mapPeakSearchSuggestionUIModel(from: peaks)
                return
            }

            let filteredPeaks = peaks.filter {
                $0.name.localizedCaseInsensitiveContains(text)
            }
            
            searchViewUIModel.filteredSuggestionUIModel = searchUIMapper.mapPeakSearchSuggestionUIModel(from: filteredPeaks)
        }
    }
}


// MARK: - Route Extension

extension HomeView.ViewModel {
    enum Route: Hashable {
        case info
    }
}
