//
//  ErrorAlertModifier.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {

    @Binding var isPresented: Bool
    let onSubmit: () -> Void

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

extension View {
    func errorAlert(isPresented: Binding<Bool>, onSubmit: @escaping () -> Void) -> some View {
        modifier(ErrorAlertModifier(isPresented: isPresented, onSubmit: onSubmit))
    }
}
