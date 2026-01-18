//
//  PeakInfoDataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

struct PeakInfoDataModule: BaseDataModule {
    
    // MARK: - Properties
    
    let container: Container
    
    
    // MARK: - Implementation
    
    func useCases() {
        container.register(GetPeakInfoUseCase.self) { resolver in
            GetPeakInfoUseCaseImpl(peaksRepository: resolver.resolve())
        }
    }
}
