//
//  SearchUIMapper.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

protocol SearchUIMapper {
    func mapPeakSearchSuggestionUIModel(from peaks: [Peak]) -> [SearchUIModel]
    func map(_ peak: Peak) -> SearchUIModel
}

class SearchUIMapperImpl: SearchUIMapper {
    
    func mapPeakSearchSuggestionUIModel(from peaks: [Peak]) -> [SearchUIModel] {
        return peaks.compactMap(map)
    }
    
    func map(_ peak: Peak) -> SearchUIModel {
        return SearchUIModel(id: peak.id,
                                 name: peak.name,
                                 icon: "mountain.2.fill",
                                 elevation: peak.elevation)
    }
}
