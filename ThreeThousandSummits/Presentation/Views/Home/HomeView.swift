//
//  HomeView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 12/1/26.
//

import SwiftUI

struct HomeView: BaseMainView {
    
    // MARK: - Public Properties
    
    @ObservedObject var viewModel: Self.ViewModel
    
    
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

//#Preview {
//    HomeView(viewModel: .init())
//}
