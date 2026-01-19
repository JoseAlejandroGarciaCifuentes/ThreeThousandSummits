//
//  PeakInfoView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI
import Kingfisher

struct PeakInfoView: BaseMainView {
    
    // MARK: - Public Properties
    
    @ObservedObject var viewModel: Self.ViewModel
    

    // MARK: - Body
    
    var body: some View {
        content
        
        // MARK: - Loader
        .loadingOverlay(isLoading: viewModel.isLoading)
        
        // MARK: - NavBar
        .navigationTitle("Peak Info")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - LifeCyle
        .lifecycle(on: viewModel)
    }
    
    
    // MARK: - Accessory Views
    
    private var content: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 20) {
                    header(width: geo.size.width)
                    Divider()
                    detailInfo
                }
                .frame(width: geo.size.width)
            }
        }
    }
    
    private func header(width: CGFloat) -> some View {
        VStack(spacing: 20) {
            peakImage(width: width)
            
            Text(viewModel.peakInfoUIModel?.name ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Text("\(viewModel.peakInfoUIModel?.elevation ?? 0) m")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    @ViewBuilder private func peakImage(width: CGFloat) -> some View {
        if let url = viewModel.peakInfoUIModel?.imageUrl {
            KFImage.url(url)
                .downsampling(size: .init(width: width, height: 220))
                .resizable()
                .cacheMemoryOnly()
                .placeholder {
                    placeholderImage
                }
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipped()
        } else {
           placeholderImage
                .frame(maxWidth: .infinity)
                .frame(height: 220)
        }
    }
    
    private var placeholderImage: some View {
        ZStack {
            Color.gray.opacity(0.15)
            
            Image(systemName: "mountain.2.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
        }
    }
    
    private var detailInfo: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About this peak")
                .font(.headline)

            Text(viewModel.peakInfoUIModel?.description ?? "")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
