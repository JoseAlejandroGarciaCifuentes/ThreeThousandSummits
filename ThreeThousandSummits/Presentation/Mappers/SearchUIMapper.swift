//
//  SearchUIMapper.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

struct SearchUIMapper {
    
    func mapPeakSearchSuggestionUIModel(from peaks: [Peak]) -> [PeakSearchUIModel] {
        return peaks.compactMap(map)
    }
    
    func map(_ peak: Peak) -> PeakSearchUIModel {
        return PeakSearchUIModel(id: peak.id,
                                 name: peak.name,
                                 icon: "mountain.2.fill",
                                 elevation: peak.elevation)
    }
}
