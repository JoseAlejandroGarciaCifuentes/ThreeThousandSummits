//
//  BaseViewModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

protocol BaseViewModule {
    var container: Container { get }
    init(container: Container)
    
    // SwiftUI
    func uiMappers()
    func viewModels()
    func views()
}


// MARK: - Default Implementation

extension BaseViewModule {
    
    func uiMappers() {}
    func viewModels() {}
    func views() {}
    
    func register<View: BaseMainView>(view: View.Type) {
        container.register(view.self) { resolver in
            let view = View(viewModel: resolver.resolve(view.Model.self)!)
            
            return view
        }
    }
    
}
