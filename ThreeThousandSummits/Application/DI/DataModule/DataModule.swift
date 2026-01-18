//
//  DataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

final class DataModule {
    
    static func setup(with container: Container) {
        let modules: [BaseDataModule.Type] = [
            HomeDataModule.self,
            PeakInfoDataModule.self,
            UserDefaultsDataModule.self
        ]
        
        // Register NetworkDataModule
        let networkDataModule = NetworkDataModule.init(container: container)
        networkDataModule.register()
        
        // Create and register modules
        modules.forEach { module in
            let dataModule = module.init(container: container)
            dataModule.register()
        }
    }
}

// MARK: - Base DataModule registration

private extension BaseDataModule {
    
    func register() {
        // Data
        dataMappers()
        providers()
        repositories()
        
        // Domain
        useCases()
    }
    
}
