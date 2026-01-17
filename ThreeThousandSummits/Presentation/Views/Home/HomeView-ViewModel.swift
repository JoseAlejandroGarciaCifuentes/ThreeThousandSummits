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
        
        private(set) var searchViewUIModel: PeaksSearchView.UIModel = .init()
        
        
        // MARK: - LifeCycle
        
        override func onAppear() {
            handleEvents()
            getPeaks()
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
