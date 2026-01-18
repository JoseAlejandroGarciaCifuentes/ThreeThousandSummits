//
//  AppNavigationModifier.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI

struct AppNavigationModifier<Route: Hashable, Destination: View>: ViewModifier {

    // MARK: - Public Properties
    
    @Binding var path: [Route]
    let destination: (Route) -> Destination

    // MARK: - Body
    
    func body(content: Content) -> some View {
        NavigationStack(path: $path) {
            content
                .navigationDestination(for: Route.self) { route in
                    destination(route)
                }
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - View Extension

extension View {

    func withAppNavigation<Route: Hashable, Destination: View>(
        path: Binding<[Route]>,
        @ViewBuilder destination: @escaping (Route) -> Destination) -> some View {
        modifier(AppNavigationModifier(path: path, destination: destination))
    }
}
