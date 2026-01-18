//
//  PeakDataMapper.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

protocol PeakDataMapper {
    func mapPeaks(from response: OverpassDTO) -> [Peak]
    func mapPeakInfo(from response: WikipediaDTO) -> PeakInfo?
}

final class PeakDataMapperImpl: PeakDataMapper {
    
    // MARK: - Public Methods
    
    func mapPeaks(from response: OverpassDTO) -> [Peak] {
        return response.elements?.compactMap { mapEntity(from: $0) } ?? []
    }
    
    func mapPeakInfo(from response: WikipediaDTO) -> PeakInfo? {
        guard let peakDetail = response.query?.pages?.values.first,
              let id = peakDetail.pageid
        else { return nil }
        
        return PeakInfo(id: id,
                        title: peakDetail.title,
                        description: peakDetail.extract,
                        imageURL: peakDetail.original?.source)
    }
    
    
    // MARK: - Private Methods
    
    private func mapEntity(from response: OverpassElementDTO) -> Peak? {
        guard let id = response.id,
              let name = response.tags?.name,
              let ele = response.tags?.ele,
              let elevation = Int(ele.filter(\.isNumber)),
              let latitude = response.lat,
              let longitude = response.lon,
              let wikipedia = response.tags?.wikipedia
        else { return nil }
        
        let wikipediaInfoSplitted = wikipedia.split(separator: ":").map(String.init)
        let lang = wikipediaInfoSplitted.first
        let wikiName = wikipediaInfoSplitted[safe: 1]
        
        return Peak(id: id,
                    name: name,
                    elevation: elevation,
                    coordinate: .init(latitude: latitude, longitude: longitude),
                    lang: lang,
                    wikiName: wikiName)
    }
}

