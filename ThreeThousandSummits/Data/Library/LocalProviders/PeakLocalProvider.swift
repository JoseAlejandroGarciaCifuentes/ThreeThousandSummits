//
//  PeakLocalProvider.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

protocol PeakLocalProvider {
    func getPeaks() async -> [Peak]?
    func set(peaks: [Peak]) async
}

final actor PeakLocalProviderImpl: PeakLocalProvider {
    
    // MARK: - Private Properties
    
    private let peaksUserDefaults: PeaksUserDefaults
    
    
    // MARK: - Init
    
    init(peaksUserDefaults: PeaksUserDefaults) {
        self.peaksUserDefaults = peaksUserDefaults
    }
    
    
    // MARK: - Implementation
    
    func getPeaks() async -> [Peak]? {
        return await peaksUserDefaults.getPeaks()
    }
    
    func set(peaks: [Peak]) async {
        await peaksUserDefaults.setPeaks(peaks)
    }
}

