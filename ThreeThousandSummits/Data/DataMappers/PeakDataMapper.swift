//
//  PeakDataMapper.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import CoreLocation

final class PeakDataMapper {
    
    func mapPeaks(from response: OverpassDTO) -> [Peak] {
        return response.elements?.compactMap { mapEntity(from: $0) } ?? []
    }
    
    private func mapEntity(from response: OverpassElementDTO) -> Peak? {
        guard
            let id = response.id,
            let name = response.tags?.name,
            let ele = response.tags?.ele,
            let elevation = Int(ele.filter(\.isNumber)),
            let latitude = response.lat,
            let longitude = response.lon
        else { return nil }
        
        return Peak(
            id: id,
            name: name,
            elevation: elevation,
            coordinate: .init(
                latitude: latitude,
                longitude: longitude
            )
        )
    }
}
