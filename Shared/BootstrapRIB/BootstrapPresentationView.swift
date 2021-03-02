//
//  BootstrapViewPresentation.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import RIBs
import Foundation
import SwiftUI

final class BootstrapPresentationViewModel: ObservableObject {

}

struct BootstrapPresentationView: Viewable {

    @ObservedObject private var viewModel: BootstrapPresentationViewModel
    private let bootstrapView: BootstrapView

    init(viewModel: BootstrapPresentationViewModel,
         bootstrapView: BootstrapView) {
        self.viewModel = viewModel
        self.bootstrapView = bootstrapView
    }

    var body: some View {
        return bootstrapView
    }
}
