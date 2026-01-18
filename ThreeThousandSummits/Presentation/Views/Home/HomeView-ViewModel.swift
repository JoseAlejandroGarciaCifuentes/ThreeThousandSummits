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
        
        
        // MARK: - Init
        
        init(getPeaksUseCase: GetPeaksUseCase) {
            self.getPeaksUseCase = getPeaksUseCase
        }
        
        
        // MARK: - Public Properties
        
        @Published var peaks: [Peak] = []
        @Published var selectedPeak: Peak?
        @Published var navigationPath: [Route] = []
        
        @Published var showErrorAlert: Bool = false
        
        private(set) var peakForNavigation: Peak?
        
        private(set) var searchViewUIModel: PeaksSearchView.UIModel = .init()
        let detailNavigationSubject = PassthroughSubject<Peak, Never>()
        
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
            
            detailNavigationSubject
                .receive(on: RunLoop.main)
                .sink { [weak self] peak in
                    guard let self else { return }
                    peakForNavigation = peak
                    selectedPeak = nil
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
                searchViewUIModel.filteredPeaks = peaks
                return
            }

            searchViewUIModel.filteredPeaks = peaks.filter {
                $0.name.localizedCaseInsensitiveContains(text)
            }
        }
    }
}


// MARK: - Route Extension

extension HomeView.ViewModel {
    enum Route: Hashable {
        case info
    }
}
