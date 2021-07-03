//
//  RootBuilder.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import DogWalkService

protocol RootDependency {
    var dogWalkService: DogWalkServicing { get }
}

final class RootComponent: Component<RootDependency>, DogWalksDependency {

    var dogWalkService: DogWalkServicing {
        return dependency.dogWalkService
    }
}

protocol RootBuilding: Buildable {
    func build() -> RootRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuilding {

    func build() -> RootRouting {
        let component = RootComponent(dependency: dependency)
        let viewModel = RootViewModel()
        let view = RootView(viewModel: viewModel)
        let presentationViewModel = RootPresentationViewModel()
        let presentationView = RootPresentationView(viewModel: presentationViewModel, rootView: view)
        let interactor = RootInteractor(controllable: viewModel,
                                        dogWalkService: component.dogWalkService)
        let router = RootRouter(interactor: interactor,
                                viewModel: presentationViewModel,
                                viewable: presentationView,
                                dogWalkBuilder: DogWalksBuilder(dependency: component))
        return router
    }
}
