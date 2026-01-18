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
        
        container.register(SearchPeaksUseCase.self) { resolver in
            SearchPeaksUseCaseImpl()
        }
    }
    
    func repositories() {
        container.register(PeaksRepository.self) { resolver in
            PeaksRepositoryImpl(networkClient: resolver.resolve(),
                                peakDataMapper: resolver.resolve(),
                                peakLocalProvider: resolver.resolve(),
                                peakInfoLocalProvider: resolver.resolve())
        }
    }
    
    func dataMappers() {
        container.register(PeakDataMapper.self) { resolver in
            PeakDataMapperImpl()
        }
    }
    
    func providers() {
        container.register(PeakLocalProvider.self) { resolver in
            PeakLocalProviderImpl(peaksUserDefaults: resolver.resolve())
        }.inObjectScope(.container)
        
        container.register(PeakInfoLocalProvider.self) { resolver in
            PeakInfoLocalProviderImpl()
        }.inObjectScope(.container)
    }
}
