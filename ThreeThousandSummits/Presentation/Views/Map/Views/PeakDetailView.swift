//
//  PeakDetailView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 16/1/26.
//

import SwiftUI
import CoreLocation

struct PeakDetailView: View {
    
    // MARK: - Public Properties
    
    let uiModel: Self.UIModel
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            header
            Divider()
            detailInfo
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

            Text(uiModel.peak.name)
                .font(.title2)
                .fontWeight(.semibold)

            Text("\(uiModel.peak.elevation) m")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var detailInfo: some View {
        VStack(spacing: 12) {
            infoRow(
                title: "Height",
                value: "\(uiModel.peak.elevation) meters",
                icon: "arrow.up"
            )

            infoRow(
                title: "Coordinates",
                value: uiModel.formattedCoordinates,
                icon: "location.fill"
            )
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
}

extension PeakDetailView {
    struct UIModel {
        let peak: Peak
        
        var formattedCoordinates: String {
            String(
                format: "%.4f, %.4f",
                peak.coordinate.latitude,
                peak.coordinate.longitude
            )
        }
    }
}
