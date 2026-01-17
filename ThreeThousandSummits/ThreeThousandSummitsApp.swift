//
//  ThreeThousandSummitsApp.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 12/1/26.
//

import SwiftUI

@main
struct ThreeThousandSummitsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .init())
        }
    }
}
