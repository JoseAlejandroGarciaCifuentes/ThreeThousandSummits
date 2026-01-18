//
//  GetPeakInfoUseCaseMock.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

@testable import ThreeThousandSummits

final class GetPeakInfoUseCaseMock: GetPeakInfoUseCase {

        var result: Result<PeakInfo?, Error> = .success(nil)

        func execute(with peak: Peak) async throws -> PeakInfo? {
            switch result {
            case .success(let info):
                return info
            case .failure(let error):
                throw error
            }
        }
    }
