//
//  Peak.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 14/1/26.
//

import CoreLocation

struct Peak: Identifiable, Hashable, Codable, Sendable {
    let id: Int
    let name: String
    let elevation: Int
    let coordinate: Coordinate
    let lang: String?
    let wikiName: String?
    
    static func == (lhs: Peak, rhs: Peak) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Coordinate: Hashable, Codable, Sendable {
    let latitude: Double
    let longitude: Double
}

extension Coordinate {
    var clLocationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
