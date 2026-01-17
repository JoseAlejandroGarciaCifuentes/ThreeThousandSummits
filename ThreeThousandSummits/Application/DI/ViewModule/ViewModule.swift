//
//  ViewModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

class ViewModule {
    
    static func setup(with container: Container) {
        Container.loggingFunction = .none
        
        let modules: [BaseViewModule.Type] = [
            HomeViewModule.self
        ]
        
        // Create and register modules
        modules.forEach { module in
            let viewModule = module.init(container: container)
            viewModule.register()
        }
    }
    
}



// MARK: - Base ViewModule registration

private extension BaseViewModule {
    
    func register() {
        uiMappers()
        viewModels()
        views()
    }
    
}
