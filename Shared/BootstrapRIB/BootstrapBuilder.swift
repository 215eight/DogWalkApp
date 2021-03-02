//
//  BootstrapBuilder.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import DogWalkService

final class BootstrapComponent: Component<EmptyDependency>, RootDependency {

    let dogWalkService: DogWalkServicing

    init(dogWalkService: DogWalkServicing) {
        self.dogWalkService = dogWalkService
        super.init(dependency: EmptyComponent())
    }
}
protocol BootstrapBuilding: Buildable {
    associatedtype RouterType: BootstrapRouting
    func build() -> RouterType
}

final class BootstrapBuilder: Builder<EmptyDependency>, BootstrapBuilding {

    func build() -> BootstrapRouter {
        let viewModel = BootstrapViewModel()
        let view = BootstrapView(viewModel: viewModel)
        let presentationViewModel = BootstrapPresentationViewModel()
        let presentationView = BootstrapPresentationView(viewModel: presentationViewModel, bootstrapView: view)
        let interactor = BootstrapInteractor(controllable: viewModel)
        let router = BootstrapRouter(interactor: interactor,
                                     view: presentationView,
                                     viewModel: presentationViewModel)
        return router
    }
}
