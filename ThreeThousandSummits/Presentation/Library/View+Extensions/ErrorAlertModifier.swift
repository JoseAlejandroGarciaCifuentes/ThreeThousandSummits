//
//  ErrorAlertModifier.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {

    // MARK: - Public Properties
    
    @Binding var isPresented: Bool
    let onSubmit: () -> Void

    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .alert(
                "Error",
                isPresented: $isPresented
            ) {
                Button("Retry") {
                    onSubmit()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Failed to load peaks. Please try again.")
            }
    }
}

// MARK: - View Extension

extension View {
    func errorAlert(isPresented: Binding<Bool>, onSubmit: @escaping () -> Void) -> some View {
        modifier(ErrorAlertModifier(isPresented: isPresented, onSubmit: onSubmit))
    }
}
