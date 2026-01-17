//
//  BaseUIModel.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Combine
import Foundation

class ObservableBaseUIModel: BaseUIModel, ObservableObject {}

class BaseUIModel: Loadable {
    
    // MARK: - Properties
    
    internal var disposables: Set<AnyCancellable>
    
    
    // MARK: - Init
    
    internal init() {
        self.disposables = Set<AnyCancellable>()
    }
    
    deinit {
        self.disposables.cancel()
    }
    
    
    // MARK: - Lifecycle
    
    open func onFirstAppear() {}
    open func onAppear() {}
    open func onDisappear() {}
    
    
    // MARK: - Loading
    
    @Published private(set) var isLoading: Bool = false
    
    
    // MARK: - Internal Methods
    
    internal func showLoading() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    
    internal func hideLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
}
