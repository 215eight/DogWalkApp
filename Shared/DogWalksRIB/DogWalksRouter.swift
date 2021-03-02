//
//  DogWalksRouter.swift
//  DogWalkApp
//
//  Created on 2/19/21
//

import Foundation
import RIBs

protocol DogWalksRouting: ViewableRouting {}

final class DogWalksRouter: ViewableRouter<DogWalksInteractable, DogWalksPresentationView> {

    override init(interactor: DogWalksInteractable, view: DogWalksPresentationView) {
        super.init(interactor: interactor, view: view)
        interactor.router = self
    }
}

extension DogWalksRouter: DogWalksRouting {}
