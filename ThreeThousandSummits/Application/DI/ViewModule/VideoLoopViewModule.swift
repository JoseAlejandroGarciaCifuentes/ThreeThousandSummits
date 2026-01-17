//
//  HomeViewModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

struct HomeViewModule: BaseViewModule {
    
    // MARK: - Properties
    
    internal let container: Container
    
    func views() {
        register(view: HomeView.self)
    }
    
    func viewModels() {
        container.register(HomeView.ViewModel.self) { resolver in
            HomeView.ViewModel(getPeaksUseCase: resolver.resolve())
        }
    }
}

