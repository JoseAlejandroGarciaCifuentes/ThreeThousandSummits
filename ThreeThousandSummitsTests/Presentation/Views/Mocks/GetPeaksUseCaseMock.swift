//
//  GetPeaksUseCaseMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class GetPeaksUseCaseMock: GetPeaksUseCase {

    var result: Result<[Peak], Error> = .success([])

    func execute(forceUpdate: Bool) async throws -> [Peak] {
        switch result {
        case .success(let peaks):
            return peaks
        case .failure(let error):
            throw error
        }
    }
}
