//
//  BaseView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI

protocol BaseView: View {
    associatedtype Model: BaseUIModel
    var uiModel: Model { get }
    init(uiModel: Model)
}
