//
//  MainContainer.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

final class MainContainer {
    
    // MARK: - Shared MainContainer
    
    private static let shared = MainContainer()
    
    
    // MARK: - Container
    
    private let container = Container()
    
    
    // MARK: - Init
    
    private init() {
        // Default behaviour
        setupModules()
    }
    
    
    // MARK: - Public methods
    
    static func registerDependencies() {
        _ = self.shared
    }
    
    
    // MARK: - Private methods
    
    private func setupModules() {
        DataModule.setup(with: container)
        ViewModule.setup(with: container)
    }
    
}


extension MainContainer {
    
    static func register(assemblies: [Assembly]) {
        let assembler = Assembler(container: shared.container)
        assembler.apply(assemblies: assemblies)
    }
    
}



// MARK: - Syncronize Resolve

extension MainContainer {
    
    private static let threadSafeContainer = shared.container.synchronize()
    
    static func resolveSync<Service>() -> Service {
        guard let service = threadSafeContainer.resolve(Service.self) else {
            fatalError("Error resolving [threadSafe] \(Service.self).self dependency")
        }
        return service
    }
    
}


// MARK: - Resolver

extension Resolver {
    func resolve<Service>() -> Service {
        guard let service = resolve(Service.self) else {
            fatalError("Error resolving \(Service.self).self dependency")
        }
        return service
    }
}


// MARK: - Injection Property Wrapper

@propertyWrapper struct InjectSync<Service> {
    var wrappedValue: Service
    
    init() {
        self.wrappedValue = MainContainer.resolveSync()
    }
}
