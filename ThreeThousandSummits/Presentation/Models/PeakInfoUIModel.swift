//
//  PeakInfoUIModel.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation

struct PeakInfoUIModel {
    let id = UUID()
    let name: String
    let elevation: Int?
    let description: String?
    let imageUrl: URL?
}
