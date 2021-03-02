//
//  BootstrapView.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import SwiftUI
import RIBs

final class BootstrapViewModel: ObservableObject {
    @Published var rootView: RootPresentationView?
}

struct BootstrapView: View {

    @ObservedObject var viewModel: BootstrapViewModel

    init(viewModel: BootstrapViewModel) {
        self.viewModel = viewModel
    }

    @ViewBuilder var body: some View {
        if let rootView = viewModel.rootView {
            NavigationView {
                rootView.uiView
            }
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            Color.white
        }
    }
}
