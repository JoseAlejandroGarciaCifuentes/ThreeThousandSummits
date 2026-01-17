//
//  HomeView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 12/1/26.
//

import SwiftUI
import CoreLocation // temporary
import Combine

struct HomeView: BaseMainView {
    
    // MARK: - Public Properties
    
    var viewModel: Self.ViewModel
    
    
    // MARK: - Private Properties
    @State private var selectedPeak: Peak?
    
    
    // MARK: - Body
    
    var body: some View {
        MapView(uiModel: .init(peaks: viewModel.peaks), selectedPeak: $selectedPeak)
            .overlay(alignment: .top) {
                PeaksSearchView(uiModel: viewModel.searchViewUIModel, selectedPeak: $selectedPeak)
            }
        
            // MARK: - LifeCyle
            .lifecycle(on: viewModel)
    }
}


// MARK: - Extension

extension HomeView {
    final class ViewModel: BaseViewModel {
        
        // MARK: - Public Properties
        
        let peaks = [Peak(id: 1, name: "Aneto", elevation: 3404, coordinate: .init(latitude: 42.631, longitude: 0.656)),
                     Peak(id: 2, name: "Posets", elevation: 3328, coordinate: .init(latitude: 42.6498359, longitude: 0.4265655)),
                     Peak(id: 3, name: "Garmo Negro", elevation: 3064, coordinate: .init(latitude: 42.7716445, longitude: -0.2641782)),
                     Peak(id: 4, name: "Infierno Central", elevation: 3080, coordinate: .init(latitude: 42.7814949, longitude: -0.2605587))]
        
        private(set) var searchViewUIModel: PeaksSearchView.UIModel = .init()
        
        
        // MARK: - LifeCycle
        
        override func onAppear() {
            handleEvents()
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

//#Preview {
//    HomeView(viewModel: .init())
//}
