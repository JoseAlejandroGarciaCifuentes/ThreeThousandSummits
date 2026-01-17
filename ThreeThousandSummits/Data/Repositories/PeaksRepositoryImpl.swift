//
//  PeaksRepositoryImpl.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import CoreLocation // temporary

final class PeaksRepositoryImpl: PeaksRepository {
    
    // MARK: - Dependencies
    
    
    // MARK: - Implementation
    
    func getPeaks() async -> [Peak] {
        return [Peak(id: 1, name: "Aneto", elevation: 3404, coordinate: .init(latitude: 42.631, longitude: 0.656)),
                     Peak(id: 2, name: "Posets", elevation: 3328, coordinate: .init(latitude: 42.6498359, longitude: 0.4265655)),
                     Peak(id: 3, name: "Garmo Negro", elevation: 3064, coordinate: .init(latitude: 42.7716445, longitude: -0.2641782)),
                     Peak(id: 4, name: "Infierno Central", elevation: 3080, coordinate: .init(latitude: 42.7814949, longitude: -0.2605587))]
    }
}
