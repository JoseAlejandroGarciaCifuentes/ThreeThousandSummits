//
//  PeakInfoViewModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

struct PeakInfoViewModule: BaseViewModule {
    
    // MARK: - Properties
    
    internal let container: Container
    
    func views() {
        register(view: PeakInfoView.self)
    }
    
    func viewModels() {
        container.register(PeakInfoView.ViewModel.self) { resolver in
            PeakInfoView.ViewModel(getPeakInfoUseCase: resolver.resolve())
        }
    }
}
