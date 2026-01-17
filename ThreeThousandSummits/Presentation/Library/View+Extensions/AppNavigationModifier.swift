//
//  AppNavigationModifier.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI

struct AppNavigationModifier<Route: Hashable, Destination: View>: ViewModifier {

    @Binding var path: [Route]
    let destination: (Route) -> Destination

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

extension View {

    func withAppNavigation<Route: Hashable, Destination: View>(
        path: Binding<[Route]>,
        @ViewBuilder destination: @escaping (Route) -> Destination
    ) -> some View {
        modifier(
            AppNavigationModifier(
                path: path,
                destination: destination
            )
        )
    }
}
