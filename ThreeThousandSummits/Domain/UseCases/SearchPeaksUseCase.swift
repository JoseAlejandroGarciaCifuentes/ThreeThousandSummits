//
//  SearchPeaksUseCase.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation

protocol SearchPeaksUseCase {
    func execute(peaks: [Peak], query: String) -> [Peak]
}

final class SearchPeaksUseCaseImpl: SearchPeaksUseCase {

    func execute(peaks: [Peak], query: String) -> [Peak] {
        guard !query.isEmpty else { return peaks }

        return peaks.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
}
