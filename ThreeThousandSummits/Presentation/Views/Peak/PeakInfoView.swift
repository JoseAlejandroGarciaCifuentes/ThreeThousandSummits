//
//  PeakInfoView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI
import CoreLocation

struct PeakInfoView: View {
    let peak: Peak?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "mountain.2.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)

                Text(peak?.name ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("\(peak?.elevation ?? 0) m")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("About this peak")
                        .font(.headline)

                    Text("""
                    \(peak?.name ?? "") is one of the most notable peaks in the Pyrenees. 
                    Located at coordinates \(peak?.coordinate.latitude ?? 0), \(peak?.coordinate.longitude ?? 0),
                    it offers stunning views and is a popular destination for mountaineers.
                    """)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Peak Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}
