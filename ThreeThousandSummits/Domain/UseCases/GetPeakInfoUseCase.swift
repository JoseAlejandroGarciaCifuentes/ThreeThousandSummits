//
//  GetPeakInfoUseCase.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

protocol GetPeakInfoUseCase {
    func execute(with peak: Peak) async throws -> PeakInfo?
}

struct GetPeakInfoUseCaseImpl: GetPeakInfoUseCase {
    
    // MARK: - Dependencies
    
    let peaksRepository: PeaksRepository
    
    
    // MARK: - Implementation
    
    func execute(with peak: Peak) async throws -> PeakInfo? {
        return try await peaksRepository.getPeakInfo(for: peak)
    }
    
}
