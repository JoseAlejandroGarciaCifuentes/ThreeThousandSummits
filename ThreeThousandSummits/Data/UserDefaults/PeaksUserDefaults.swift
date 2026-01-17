//
//  PeaksUserDefaults.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Foundation

protocol PeaksUserDefaults: Sendable {
    func getPeaks() -> [Peak]?
    func setPeaks(_ peaks: [Peak])
}

extension UserDefaults: PeaksUserDefaults {
    
    func getPeaks() -> [Peak]? {
        guard let data = data(forKey: "peaks") else { return nil }
        return try? JSONDecoder().decode([Peak].self, from: data)
    }
    
    func setPeaks(_ peaks: [Peak]) {
        let data = try? JSONEncoder().encode(peaks)
        set(data, forKey: "peaks")
    }
    
}
