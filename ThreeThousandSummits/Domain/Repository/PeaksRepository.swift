//
//  PeaksRepository.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

protocol PeaksRepository {
    func getPeaks() async throws -> [Peak]
}
