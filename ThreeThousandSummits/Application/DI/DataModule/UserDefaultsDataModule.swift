//
//  UserDefaultsDataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject
import Foundation

struct UserDefaultsDataModule: BaseDataModule {
    
    // MARK: - Properties
    
    internal let container: Container
    
    
    // MARK: - Data
    
    func providers() {
        container.register(PeaksUserDefaults.self) { _ in UserDefaults.standard }
    }
    
}
