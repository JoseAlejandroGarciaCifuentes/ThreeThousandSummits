//
//  PeaksSearchView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 16/1/26.
//

import SwiftUI
import Combine

struct PeaksSearchView: View {

    // MARK: - Public Properties
    
    @ObservedObject var uiModel: Self.UIModel
    @Binding var selectedPeak: Peak?
    
    
    // MARK: - Private Properties
    
    @State private var suggestionsHeight: CGSize = .zero

    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            suggestions
        }
    }
    
    
    // MARK: - Accessory Views
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Find Peak…", text: $uiModel.searchText)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
    }
    
    @ViewBuilder private var suggestions: some View {
        if !uiModel.searchText.isEmpty {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(uiModel.filteredPeaks.prefix(6)) { peak in
                        suggestionButton(with: peak)
                        Divider()
                    }
                }
                .readSize($suggestionsHeight)
            }
            .frame(maxHeight: suggestionsHeight.height)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
        }
    }
    
    private func suggestionButton(with peak: Peak) -> some View {
        Button {
            selectedPeak = peak
            uiModel.searchText = ""
        } label: {
            HStack {
                Image(systemName: "mountain.2.fill")
                Text(peak.name)
                Spacer()
                Text("\(peak.elevation)m")
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .buttonStyle(.plain)
    }
    
}


// MARK: - Extension

extension PeaksSearchView {
    final class UIModel: ObservableBaseUIModel {
        
        // MARK: - Public Properties
        
        @Published var searchText: String = ""
        @Published var filteredPeaks: [Peak] = []
    }
}
