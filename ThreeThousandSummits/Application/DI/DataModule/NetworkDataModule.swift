//
//  NetworkDataModule.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Swinject

struct NetworkDataModule {
    let container: Container

    func register() {
        container.register(NetworkClient.self) { _ in
            NetworkClientImpl()
        }
        .inObjectScope(.container)
    }
}
