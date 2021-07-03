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

final class RootRouter: ViewableRouter<RootInteractable, RootPresentationViewModel> {

    private var dogWalksRouter: DogWalksRouter?

    private let dogWalkBuilder: DogWalksBuilder

    init(interactor: RootInteractable,
         viewModel: RootPresentationViewModel,
         viewable: Viewable,
         dogWalkBuilder: DogWalksBuilder) {
        self.dogWalkBuilder = dogWalkBuilder
        super.init(interactor: interactor, viewModel: viewModel, viewable: viewable)
        interactor.router = self
    }
}

extension RootRouter: RootRouting {

    func routeToDogWalks(dog: Dog) {
        let router = dogWalkBuilder.build(dog: dog, listener: interactor)

        viewModel.navigationPresenter.push(router, from: self) {
            self.dogWalksRouter = router
        } onDismiss: {
            self.dogWalksRouter = nil
        }
    }

    func routeAwayFromDogWalks(_ router: DogWalksRouter) {
        viewModel.navigationPresenter.pop(router, from: self) {
            self.dogWalksRouter = nil
        }
    }
}
