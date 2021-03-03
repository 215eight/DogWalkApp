//
//  RootRouter.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import DogWalkService

protocol RootRouting: ViewableRouting {
    func routeToDogWalks(dog: Dog)
    func routeAwayFromDogWalks(_ router: DogWalksRouter)
}

final class RootRouter: ViewableRouter<RootInteractable, RootPresentationView> {

    private var dogWalksRouter: DogWalksRouter?

    private let viewModel: RootPresentationViewModel
    private let dogWalkBuilder: DogWalksBuilder

    init(interactor: RootInteractable,
         view: RootPresentationView,
         viewModel: RootPresentationViewModel,
         dogWalkBuilder: DogWalksBuilder) {
        self.viewModel = viewModel
        self.dogWalkBuilder = dogWalkBuilder
        super.init(interactor: interactor, view: view)
        interactor.router = self
    }
}

extension RootRouter: RootRouting {

    func routeToDogWalks(dog: Dog) {
        let router = dogWalkBuilder.build(dog: dog, listener: interactor)
        viewModel.navigationPresenter.push(router, from: self) {
            self.dogWalksRouter = router
        }
    }

    func routeAwayFromDogWalks(_ router: DogWalksRouter) {
        viewModel.navigationPresenter.pop(router, from: self) {
            self.dogWalksRouter = nil
        }
    }
}
