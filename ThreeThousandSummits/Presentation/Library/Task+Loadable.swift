//
//  Loadable.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

extension Task where Failure == Error {

    @discardableResult
    init(priority: TaskPriority? = nil,
        loadable: Loadable?,
        @_inheritActorContext @_implicitSelfCapture
        operation: __owned @Sendable @escaping () async -> Success) {
        self = Task(priority: priority) {
            await loadable?.show()
            let result = await operation()
            await loadable?.hide()
            return result
        }
    }

    @discardableResult
    init(priority: TaskPriority? = nil,
        loadable: Loadable?,
        @_inheritActorContext @_implicitSelfCapture
        operation: __owned @Sendable @escaping () async throws -> Success) {
        self = Task(priority: priority) {
            await loadable?.show()
            do {
                let result = try await operation()
                await loadable?.hide()
                return result
            } catch {
                await loadable?.hide()
                throw error
            }
        }
    }
}

private extension Loadable {
    
    func show() async {
        await MainActor.run {
            showLoading()
        }
    }
    
    func hide() async {
        await MainActor.run {
            hideLoading()
        }
    }
    
}
