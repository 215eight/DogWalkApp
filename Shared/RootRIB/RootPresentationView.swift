//
//  RootPresentationView.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import SwiftUI
import Foundation
import RIBs

final class RootPresentationViewModel: ObservableObject {
    @Published var navigationPresenter = NavigationPresenter<DogWalksRouter>()
}

struct RootPresentationView: View, Viewable {

    @ObservedObject private var viewModel: RootPresentationViewModel
    private let rootView: RootView

    init(viewModel: RootPresentationViewModel, rootView: RootView) {
        self.viewModel = viewModel
        self.rootView = rootView
    }

    var body: some View {
        return VStack {
            rootView
            NavigationPresenterView(navigationPresenter: viewModel.navigationPresenter)
        }
    }
}
