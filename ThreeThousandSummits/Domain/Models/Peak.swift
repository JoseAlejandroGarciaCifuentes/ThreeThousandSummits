//
//  Peak.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 14/1/26.
//

import CoreLocation

struct Peak: Identifiable, Hashable {
    let id: Int
    let name: String
    let elevation: Int
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: Peak, rhs: Peak) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
