//
//  BaseDataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

protocol BaseDataModule {
    var container: Container { get }
    init(container: Container)
    
    // Data
    func singletons()
    func dataMappers()
    func providers()
    func repositories()
    
    // Domain
    func entityMappers()
    func useCases()
}


// MARK: - Default Implementation

extension BaseDataModule {
    func singletons() {}
    func dataMappers() {}
    func providers() {}
    func repositories() {}
    
    func entityMappers() {}
    func useCases() {}
}
