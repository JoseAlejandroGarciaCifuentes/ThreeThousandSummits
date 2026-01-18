//
//  PeakInfoView-ViewModel.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Combine

extension PeakInfoView {
    final class ViewModel: BaseViewModel {
        
        // MARK: - Dependencies
        
        // UseCases
        private let getPeakInfoUseCase: GetPeakInfoUseCase
        
        // UIMapper
        private let peakUIMapper: PeakUIMapper
        
        
        // MARK: - Init
        
        init(getPeakInfoUseCase: GetPeakInfoUseCase,
             peakUIMapper: PeakUIMapper) {
            self.getPeakInfoUseCase = getPeakInfoUseCase
            self.peakUIMapper = peakUIMapper
        }
        
        
        // MARK: - Public Properties
        
        @Published var peakInfoUIModel: PeakInfoUIModel? = nil
        
        
        // MARK: - Private Properties
        
        private var getPeakInfoTask: Task<Void, Error>?
        
        
        // MARK: - LifeCycle
        
        @MainActor
        deinit {
            getPeakInfoTask?.cancel()
        }
        
        
        // MARK: - Setup
        
        func setup(peak: Peak?) {
            getPeakInfo(with: peak)
        }
        
        
        // MARK: - Private Methods
        
        private func getPeakInfo(with peak: Peak?) {
            guard let peak else { return }
            
            getPeakInfoTask?.cancel()
            
            getPeakInfoTask = Task(loadable: self) {
                do {
                    let peakInfo = try await getPeakInfoUseCase.execute(with: peak)
                    try Task.checkCancellation()
                    
                    await MainActor.run {
                        peakInfoUIModel = peakUIMapper.mapPeakInfoUIModel(from: peakInfo, and: peak)
                    }
                } catch is CancellationError {
                } catch {
                    // TODO: - Show error
                }
            }
        }
    }
}
