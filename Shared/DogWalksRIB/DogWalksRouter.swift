//
//  DogWalksRouter.swift
//  DogWalkApp
//
//  Created on 2/19/21
//

import Foundation
import RIBs

protocol DogWalksRouting: ViewableRouting {}

final class DogWalksRouter: ViewableRouter<DogWalksInteractable, DogWalksPresentationViewModel> {

    override init(interactor: DogWalksInteractable,
                  viewModel: DogWalksPresentationViewModel,
                  viewable: Viewable) {
        super.init(interactor: interactor, viewModel: viewModel, viewable: viewable)
        interactor.router = self
    }
}

extension DogWalksRouter: DogWalksRouting {}
