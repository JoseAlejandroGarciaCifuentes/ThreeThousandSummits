//
//  BaseMainView+DI.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

extension BaseMainView {
    
    static func instance() -> Self {
        guard let view: Self = MainContainer.resolveSync() else {
            fatalError("Couldn't instantiate SwiftUI view [\(Self.self).self], register in Dependency Injection first.")
        }
        return view
    }
    
}
