//
//  SearchPeaksUseCaseMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class SearchPeaksUseCaseMock: SearchPeaksUseCase {

    var executeCalled = false
    var peaksResult: [Peak] = []

    func execute(peaks: [Peak], query: String) -> [Peak] {
        executeCalled = true
        return peaksResult
    }
}
