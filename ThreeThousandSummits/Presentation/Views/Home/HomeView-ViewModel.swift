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
        
        private(set) var peakForNavigation: Peak?
        
        private(set) var searchViewUIModel: PeaksSearchView.UIModel = .init()
        let detailNavigationSubject = PassthroughSubject<Peak, Never>()
        
        
        // MARK: - Private Properties
        
        
        
        
        // MARK: - LifeCycle
        
        override func onAppear() {
            handleEvents()
            getPeaks()
        }
        
        enum Route: Hashable {
            case info
        }
        
        @Published var navigationPath: [Route] = []
        
        
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
        
        private func getPeaks() {
            Task {
                let peaks = await getPeaksUseCase.execute()
                
                await MainActor.run {
                    self.peaks = peaks
                }
            }.store(in: &disposables)
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
