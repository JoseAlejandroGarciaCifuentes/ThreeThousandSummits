//
//  PeakUIMapper.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation
import Combine

protocol PeakUIMapper {
    func mapPeakInfoUIModel(from peakInfo: PeakInfo?, and peak: Peak) -> PeakInfoUIModel?
    func mapPeakDetailUIModel(from peak: Peak, detailNavigationSubject: PassthroughSubject<Int, Never>) -> PeakDetailView.UIModel
}

struct PeakUIMapperImpl: PeakUIMapper {
    
    func mapPeakInfoUIModel(from peakInfo: PeakInfo?, and peak: Peak) -> PeakInfoUIModel? {
        let imageURL = peakInfo?.imageURL
            .flatMap { URL(string: $0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        
        return PeakInfoUIModel(name: peak.name, elevation: peak.elevation, description: peakInfo?.description, imageUrl: imageURL)
    }
    
    func mapPeakDetailUIModel(from peak: Peak, detailNavigationSubject: PassthroughSubject<Int, Never>) -> PeakDetailView.UIModel {
        
        let formattedCoordinates = String(format: "%.4f, %.4f", peak.coordinate.latitude, peak.coordinate.longitude)
        
        return PeakDetailView.UIModel(id: peak.id,
                                      name: peak.name,
                                      elevation: peak.elevation,
                                      coordinates: formattedCoordinates,
                                      detailNavigationSubject: detailNavigationSubject)
    }
}
