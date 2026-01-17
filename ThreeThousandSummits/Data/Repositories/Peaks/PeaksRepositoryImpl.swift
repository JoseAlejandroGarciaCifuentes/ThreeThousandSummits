//
//  PeaksRepositoryImpl.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import CoreLocation // temporary

final class PeaksRepositoryImpl: PeaksRepository {
    
    // MARK: - Dependencies
    
    private let networkClient: NetworkClient
    private let peakDataMapper: PeakDataMapper
    private let peakLocalProvider: PeakLocalProvider
    
    
    // MARK: - Init
    
    init(networkClient: NetworkClient,
         peakDataMapper: PeakDataMapper,
         peakLocalProvider: PeakLocalProvider) {
        self.networkClient = networkClient
        self.peakDataMapper = peakDataMapper
        self.peakLocalProvider = peakLocalProvider
    }
    
    
    // MARK: - Implementation
    
    func getPeaks() async throws -> [Peak] {
        // Check Local
        if let localPeaks = await peakLocalProvider.getPeaks() {
            return localPeaks
        }
        
        // Request
        let target: OverpassTarget = .getPeaks
        
        // Response
        let data = try await networkClient.request(target)
            .map(OverpassDTO.self)
        
        // Mapper
        let peaks = peakDataMapper.mapPeaks(from: data)
        
        // Save Local
        await peakLocalProvider.set(peaks: peaks)
        
        return peaks
    }
}
