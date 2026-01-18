//
//  PeakDetailView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 16/1/26.
//

import SwiftUI
import CoreLocation
import Combine

struct PeakDetailView: View {
    
    // MARK: - Public Properties
    
    let uiModel: Self.UIModel
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            header
            Divider()
            detailInfo
            detailButton
            Spacer()
        }
        .padding()
    }

    
    // MARK: - Accessory Views
    
    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "mountain.2.fill")
                .font(.system(size: 48))
                .foregroundStyle(.brown)

            Text(uiModel.name)
                .font(.title2)
                .fontWeight(.semibold)

            Text("\(uiModel.elevation) m")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var detailInfo: some View {
        VStack(spacing: 12) {
            infoRow(title: "Height", value: "\(uiModel.elevation) meters", icon: "arrow.up")

            infoRow(title: "Coordinates", value: uiModel.coordinates, icon: "location.fill")
        }
    }
    
    private func infoRow(title: String, value: String, icon: String) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var detailButton: some View {
        Button {
            uiModel.onTapDetailButton()
        } label: {
            Label("More about this peak", systemImage: "info.circle.fill")
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

extension PeakDetailView {
    struct UIModel {
        
        // MARK: - Public Properties
        
        let id: Int
        let name: String
        let elevation: Int
        let coordinates: String
        
        
        // MARK: - Private Properties
        
        let detailNavigationSubject: PassthroughSubject<Int, Never>
        
        
        // MARK: - Public Methods
        
        func onTapDetailButton() {
            detailNavigationSubject.send(id)
        }
    }
}
