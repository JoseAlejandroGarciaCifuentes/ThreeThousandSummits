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
        
        
        // MARK: - Init
        
        init(getPeakInfoUseCase: GetPeakInfoUseCase) {
            self.getPeakInfoUseCase = getPeakInfoUseCase
        }
        
        
        // MARK: - Public Properties
        
        var peak: Peak? = nil
        @Published var peakInfo: PeakInfo? = nil
        
        private var getPeakInfoTask: Task<Void, Error>?
        
        
        // MARK: - LifeCycle
        
        @MainActor
        deinit {
            getPeakInfoTask?.cancel()
        }
        
        
        // MARK: - Setup
        
        func setup(peak: Peak?) {
            self.peak = peak
            getPeakInfo()
        }
        
        
        // MARK: - Private Methods
        
        private func getPeakInfo() {
            guard let peak else { return }
            
            getPeakInfoTask?.cancel()
            
            getPeakInfoTask = Task(loadable: self) {
                do {
                    let peakInfo = try await getPeakInfoUseCase.execute(with: peak)
                    try Task.checkCancellation()
                    
                    await MainActor.run {
                        self.peakInfo = peakInfo
                    }
                } catch is CancellationError {
                } catch {
                    print(error)
                    // TODO: - Show error
                }
            }
        }
    }
}
