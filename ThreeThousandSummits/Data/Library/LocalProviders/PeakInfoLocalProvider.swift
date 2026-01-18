//
//  PeakInfoLocalProvider.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation

protocol PeakInfoLocalProvider {
    func getPeakInfo(for key: String) async -> PeakInfo?
    func setPeakInfo(_ info: PeakInfo, for key: String) async
}

final actor PeakInfoLocalProviderImpl: PeakInfoLocalProvider {

    // MARK: - Private Properties
    
    private var storage: [String: CacheEntry] = [:]
    private let ttl: TimeInterval = 180

    
    // MARK: - Public Methods
    
    func getPeakInfo(for key: String) async -> PeakInfo? {
        guard let entry = storage[key] else { return nil }

        let isValid = Date().timeIntervalSince(entry.timestamp) < ttl
        return isValid ? entry.info : nil
    }

    func setPeakInfo(_ info: PeakInfo, for key: String) async {
        storage[key] = CacheEntry(info: info, timestamp: Date())
    }
}


// MARK: - CacheEntry

extension PeakInfoLocalProviderImpl {
    struct CacheEntry {
        let info: PeakInfo
        let timestamp: Date
    }
}
