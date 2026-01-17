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

    @Binding var selectedPeak: Peak?
    
    
    // MARK: - Body

    var body: some View {
        content
        
        // MARK: - OnChange
            .onChange(of: selectedPeak) { _, peak in
                guard let peak else { return }
                focus(on: peak)
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
                coordinate: peak.coordinate.clLocationCoordinate
            )
            .tag(peak)
        }
    }
    
    
    // MARK: - Private Methods
    
    private func focus(on peak: Peak) {
        withAnimation(.easeInOut) {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: peak.coordinate.clLocationCoordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // 0.1 represents zoom
                )
            )
        }
    }
}


// MARK: - UIModel

extension MapView {
    struct UIModel {
        let peaks: [Peak]
    }
}
