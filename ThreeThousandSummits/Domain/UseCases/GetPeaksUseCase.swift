//
//  GetPeaksUseCase.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

protocol GetPeaksUseCase {
    func execute() async -> [Peak]
}

struct GetPeaksUseCaseImpl: GetPeaksUseCase {
    
    // MARK: - Dependencies
    
    let peaksRepository: PeaksRepository
    
    
    // MARK: - Implementation
    
    func execute() async -> [Peak] {
        return await peaksRepository.getPeaks()
    }
    
}
