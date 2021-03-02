//
//  BootstrapInteractor.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import SEPlatform

protocol BootstrapInteractable: Interactable {
    var router: BootstrapRouter? { get set }
    func show(rootView: RootPresentationView)
}

final class BootstrapInteractor: ViewableInteractor<BootstrapViewModel> {

    weak var router: BootstrapRouter?

    override func didBecomeActive() {
        super.didBecomeActive()
        bootstrap()
    }

    private func bootstrap() {
        let dogWalkServiceLaunchStep = DogWalkServiceLaunchStep()
        guard let dogWalkService = dogWalkServiceLaunchStep.execute(input: ()).success else {
            SEPlatform.SEfatalError()
        }

        dogWalkService.addDog(name: "Firu")
            .flatMap { dog in
                dogWalkService.addWalk(date: Date.distantPast, dogId: dog.id)
                    .flatMap { _ in dogWalkService.addWalk(date: Date(), dogId: dog.id) }
                    .flatMap { _ in dogWalkService.addWalk(date: Date.distantFuture, dogId: dog.id) }
            }
            .flatMap { _ in dogWalkService.addDog(name: "Pelu") }
            .flatMap { dog in
                dogWalkService.addWalk(date: Date.distantPast, dogId: dog.id)
                    .flatMap { _ in dogWalkService.addWalk(date: Date(), dogId: dog.id) }
            }
            .flatMap { _ in dogWalkService.addDog(name: "Molly") }
            .flatMap { dog in
                dogWalkService.addWalk(date: Date(), dogId: dog.id)
                    .flatMap { _ in dogWalkService.addWalk(date: Date.distantFuture, dogId: dog.id) }
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .cancelOnDeactivate(interactor: self)


        let bootstrapComponent = BootstrapComponent(dogWalkService: dogWalkService)

        router?.routeToRoot(component: bootstrapComponent)
    }
}

extension BootstrapInteractor: BootstrapInteractable {

    func show(rootView: RootPresentationView) {
        controllable.rootView = rootView
    }
}
