//
//  LifeCycle.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI

extension View {
    
    func lifecycle(on uiModel: BaseUIModel) -> some View {
        self
            .onAppear(perform: uiModel.onAppear)
            .onDisappear(perform: uiModel.onDisappear)
    }
    
}
