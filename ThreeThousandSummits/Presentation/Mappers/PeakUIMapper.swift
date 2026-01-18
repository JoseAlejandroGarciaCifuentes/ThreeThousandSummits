//
//  PeakUIMapper.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation

struct PeakUIMapper {
    
    func mapPeakInfoUIModel(from peakInfo: PeakInfo?, and peak: Peak) -> PeakInfoUIModel? {
        let imageURL = peakInfo?.imageURL
            .flatMap { URL(string: $0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        
        return PeakInfoUIModel(name: peak.name, elevation: peak.elevation, description: peakInfo?.description, imageUrl: imageURL)
    }
}


