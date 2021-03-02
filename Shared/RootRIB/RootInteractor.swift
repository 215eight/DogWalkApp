//
//  RootInteractor.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import SEPlatform
import DogWalkService
import Combine

protocol RootInteractable: Interactable, DogWalksListener {
    var router: RootRouter? { get set }
}

final class RootInteractor: ViewableInteractor<RootViewModel> {

    private let dogWalkService: DogWalkServicing

    weak var router: RootRouter?

    init(controllable: RootViewModel,
         dogWalkService: DogWalkServicing) {
        self.dogWalkService = dogWalkService
        super.init(controllable: controllable)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dogWalkService.fetchDogs()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { dogs in
                    self.controllable.dogs = dogs
                  })
            .cancelOnDeactivate(interactor: self)

        controllable.$selectedDog
            .compactMap { $0 }
            .sink(receiveValue: { dog in
                self.router?.routeToDogWalks(dog: dog)
            })
            .cancelOnDeactivate(interactor: self)
    }
}

extension RootInteractor: RootInteractable {
    func dismiss(_ router: DogWalksRouter) {
        self.router?.routeAwayFromDogWalks(router)
    }
}
