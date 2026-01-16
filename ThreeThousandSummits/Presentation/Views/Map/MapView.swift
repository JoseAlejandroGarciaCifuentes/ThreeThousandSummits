//
//  MapView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 14/1/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // MARK: - Public Properties
    
    let uiModel: Self.UIModel
    
    
    // MARK: - Private Properties
    
    // Coordinates set to Pyrinees mountain range
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.7, longitude: 0.7),
            span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 3.5)
        )
    )

    @State private var selectedPeak: Peak?
    
    
    // MARK: - Body

    var body: some View {
        content
            .sheet(item: $selectedPeak) { peak in
                PeakDetailView(uiModel: .init(peak: peak))
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
    }
    
    
    // MARK: - Accessory Views
    
    private var content: some View {
        Map(position: $cameraPosition, selection: $selectedPeak) {
            markers
        }
        .mapStyle(.standard(elevation: .realistic))
    }
    
    @MapContentBuilder
    private var markers: some MapContent {
        ForEach(uiModel.peaks) { peak in
            Marker(
                peak.name,
                coordinate: peak.coordinate
            )
            .tag(peak)
        }
    }
}


// MARK: - UIModel

extension MapView {
    struct UIModel {
        let peaks: [Peak]
    }
}
