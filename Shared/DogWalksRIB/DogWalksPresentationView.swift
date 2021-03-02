//
//  DogWalksPresentationView.swift
//  DogWalkApp
//
//  Created on 2/19/21
//

import Foundation
import SwiftUI
import RIBs

final class DogWalksPresentationViewModel: ObservableObject {

}

struct DogWalksPresentationView: Viewable {

    @ObservedObject private var viewModel: DogWalksPresentationViewModel
    private let dogWalksView: DogWalksView

    init(viewModel: DogWalksPresentationViewModel, dogWalksView: DogWalksView) {
        self.viewModel = viewModel
        self.dogWalksView = dogWalksView
    }

    var body: some View {
        return dogWalksView
    }
}
