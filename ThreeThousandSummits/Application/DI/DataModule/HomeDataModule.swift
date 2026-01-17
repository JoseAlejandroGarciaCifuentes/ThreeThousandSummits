//
//  HomeDataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

struct HomeDataModule: BaseDataModule {
    
    // MARK: - Properties
    
    let container: Container
    
    
    // MARK: - Implementation
    
    func useCases() {
        container.register(GetPeaksUseCase.self) { resolver in
            GetPeaksUseCaseImpl(peaksRepository: resolver.resolve())
        }
    }
    
    func repositories() {
        container.register(PeaksRepository.self) { resolver in
            PeaksRepositoryImpl()
        }
    }
}
