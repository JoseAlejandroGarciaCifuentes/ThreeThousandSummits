//
//  LoadingOverlayModifier.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import SwiftUI

struct LoadingOverlayModifier: ViewModifier {
    
    // MARK: - Public Properties
    
    let isLoading: Bool

    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea()

                        ProgressView()
                            .scaleEffect(1.3)
                            .padding(24)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
    }
}

// MARK: - View Extension

extension View {
    func loadingOverlay(isLoading: Bool) -> some View {
        modifier(LoadingOverlayModifier(isLoading: isLoading))
    }
}
