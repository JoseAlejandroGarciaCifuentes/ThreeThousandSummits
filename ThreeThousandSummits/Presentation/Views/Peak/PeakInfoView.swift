//
//  PeakInfoView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI
import CoreLocation
import Combine
import Kingfisher

struct PeakInfoView: BaseMainView {
    
    // MARK: - Public Properties
    
    @ObservedObject var viewModel: Self.ViewModel
    

    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                Divider()
                detailInfo
                Spacer()
            }
        }
        
        //MARK: - NavBar
        .navigationTitle("Peak Info")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: - Accessory Views
    
    private var header: some View {
        VStack(spacing: 20) {
            if let urlString = viewModel.peakInfo?.imageURL, let url = URL(string: urlString) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .containerRelativeFrame(.horizontal)
                    .clipped()
            }
            
            Text(viewModel.peak?.name ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Text("\(viewModel.peak?.elevation ?? 0) m")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var detailInfo: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About this peak")
                .font(.headline)

            Text(viewModel.peakInfo?.description ?? "")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}


extension PeakInfoView {
    final class ViewModel: BaseViewModel {
        
        // MARK: - Dependencies
        
        // UseCases
        private let getPeakInfoUseCase: GetPeakInfoUseCase
        
        
        // MARK: - Init
        
        init(getPeakInfoUseCase: GetPeakInfoUseCase) {
            self.getPeakInfoUseCase = getPeakInfoUseCase
        }
        
        
        // MARK: - Public Properties
        
        var peak: Peak? = nil
        @Published var peakInfo: PeakInfo? = nil
        
        
        // MARK: - Setup
        
        func setup(peak: Peak?) {
            self.peak = peak
            getPeakInfo()
        }
        
        
        // MARK: - Private Methods
        
        private func getPeakInfo() {
            guard let peak else { return }
            Task {
                do {
                    let peakInfo = try await getPeakInfoUseCase.execute(with: peak)
                    
                    await MainActor.run {
                        self.peakInfo = peakInfo
                    }
                } catch {
                    print(error)
                    // TODO: - Show error
                }
            }.store(in: &disposables)
        }
    }
}
