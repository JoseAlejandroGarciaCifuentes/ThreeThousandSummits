//
//  SearchUIModel.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 18/1/26.
//

import Foundation

struct PeakSearchUIModel: Identifiable {
    let uuid = UUID()
    let id: Int
    let name: String
    let icon: String
    let elevation: Int
}
