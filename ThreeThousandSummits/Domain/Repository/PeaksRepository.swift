//
//  PeaksRepository.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

protocol PeaksRepository {
    func getPeaks(forceUpdate: Bool) async throws -> [Peak]
    func getPeakInfo(for peak: Peak) async throws -> PeakInfo?
}
