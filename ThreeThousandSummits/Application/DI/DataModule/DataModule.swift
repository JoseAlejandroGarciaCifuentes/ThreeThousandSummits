//
//  DataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

class DataModule {
    
    static func setup(with container: Container) {
        let modules: [BaseDataModule.Type] = [
            HomeDataModule.self
        ]
        
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
        singletons()
        dataMappers()
        providers()
        repositories()
        
        // Domain
        entityMappers()
        useCases()
    }
    
}
