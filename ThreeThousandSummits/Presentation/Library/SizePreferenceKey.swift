//
//  SizePreferenceKey.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 16/1/26.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readSize(_ size: Binding<CGSize>) -> some View {
        background(GeometryReader { geometryProxy in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometryProxy.size)
        }).onPreferenceChange(SizePreferenceKey.self, perform: { newSize in
            DispatchQueue.main.async { size.wrappedValue = newSize }
        })
    }
}
