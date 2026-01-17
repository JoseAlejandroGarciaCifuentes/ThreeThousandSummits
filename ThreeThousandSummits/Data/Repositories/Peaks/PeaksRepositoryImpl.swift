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
    
    
    // MARK: - Init
    
    init(networkClient: NetworkClient, peakDataMapper: PeakDataMapper) {
        self.networkClient = networkClient
        self.peakDataMapper = peakDataMapper
    }
    
    
    // MARK: - Implementation
    
    func getPeaks() async throws -> [Peak] {
        // Request
        let target: OverpassTarget = .getPeaks
        
        let data = try await networkClient.request(target)
            .map(OverpassDTO.self)
        
        return peakDataMapper.mapPeaks(from: data)
    }
}
