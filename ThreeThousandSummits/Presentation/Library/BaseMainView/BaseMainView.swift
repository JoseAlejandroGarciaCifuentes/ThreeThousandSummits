//
//  BaseMainView.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import SwiftUI

protocol BaseMainView: View {
    associatedtype Model: BaseViewModel
    var viewModel: Model { get }
    init(viewModel: Model)
}
