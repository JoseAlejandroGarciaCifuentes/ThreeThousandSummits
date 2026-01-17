//
//  ThreeThousandSummitsApp.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 12/1/26.
//

import SwiftUI

@main
struct ThreeThousandSummitsApp: App {
    
    // MARK: - Private Properties
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            HomeView.instance()
        }
    }
}
