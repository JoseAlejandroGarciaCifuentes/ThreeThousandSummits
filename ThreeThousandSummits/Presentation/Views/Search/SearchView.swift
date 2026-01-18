//
//  SearchView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 16/1/26.
//

import SwiftUI
import Combine

struct SearchView: View {

    // MARK: - Public Properties
    
    @ObservedObject var uiModel: Self.UIModel
    @Binding var selectedId: Int?
    
    
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

            TextField(uiModel.textFieldPlaceholder, text: $uiModel.searchText)
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
                    ForEach(uiModel.filteredSuggestionUIModel.prefix(6)) { peak in
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
    
    private func suggestionButton(with suggestion: PeakSearchUIModel) -> some View {
        Button {
            selectedId = suggestion.id
            uiModel.searchText = ""
        } label: {
            HStack {
                Image(systemName: suggestion.icon)
                Text(suggestion.name)
                Spacer()
                Text("\(suggestion.elevation)m")
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .buttonStyle(.plain)
    }
    
}


// MARK: - Extension

extension SearchView {
    final class UIModel: ObservableBaseUIModel {
        
        // MARK: - Public Properties
        
        @Published var searchText: String = ""
        @Published var filteredSuggestionUIModel: [PeakSearchUIModel] = []
        
        let textFieldPlaceholder: String
        
        init(textFieldPlaceholder: String) {
            self.textFieldPlaceholder = textFieldPlaceholder
        }
    }
}
