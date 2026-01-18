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
    
    
    // MARK: - Body
    
    var body: some View {
        MapView(uiModel: .init(peaks: viewModel.peaks), selectedPeak: $viewModel.selectedPeak)
        
            // MARK: - Search Bar
            .overlay(alignment: .top) {
                PeaksSearchView(uiModel: viewModel.searchViewUIModel, selectedPeak: $viewModel.selectedPeak)
            }
        
            // MARK: - Refresh Button
            .overlay(alignment: .bottomTrailing, content: refreshButton)
        
            // MARK: - Loader
            .loadingOverlay(isLoading: viewModel.isLoading)
        
            // MARK: - Alert
            .errorAlert(isPresented: $viewModel.showErrorAlert, onSubmit: { viewModel.getPeaks(forceUpdate: true) })
        
            // MARK: - Navigation
            .withAppNavigation(path: $viewModel.navigationPath) { route in
                switch route {
                case .info:
                    let view = PeakInfoView.instance()
                    view.viewModel.setup(peak: viewModel.peakForNavigation)
                    return view
                }
            }
        
            // MARK: - Sheet
            .sheet(item: $viewModel.selectedPeak) { peak in
                PeakDetailView(uiModel: .init(peak: peak, detailNavigationSubject: viewModel.detailNavigationSubject))
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        
            // MARK: - LifeCyle
            .lifecycle(on: viewModel)
        
    }
    
    
    // MARK: - Accessory Views
    
    private func refreshButton() -> some View {
        Button {
            viewModel.getPeaks(forceUpdate: true)
        } label: {
            Image(systemName: "arrow.clockwise")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .padding(16)
                .background(.blue)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        .padding()
    }
}
