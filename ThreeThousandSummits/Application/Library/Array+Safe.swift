//
//  Array+SafeSubscript.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

public extension Array {
    func element(at index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
    
    mutating func set(newValue: Element, index: Int) {
        guard indices.contains(index) else { return }
        self[index] = newValue
    }
    
    subscript(safe index: Int) -> Element? {
        get {
            return self.element(at: index)
        }
        set(newValue) {
            guard let element = newValue else { return }
            self.set(newValue: element, index: index)
        }
    }
}
