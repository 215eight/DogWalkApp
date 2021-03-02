//
//  BootstrapRouter.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import DogWalkService

protocol BootstrapRouting: ViewableRouting {
    func routeToRoot(component: BootstrapComponent)
}

final class BootstrapRouter: ViewableRouter<BootstrapInteractable, BootstrapPresentationView> {

    private var rootRouter: RootRouter?
    private let viewModel: BootstrapPresentationViewModel

    init(interactor: BootstrapInteractable,
         view: BootstrapPresentationView,
         viewModel: BootstrapPresentationViewModel) {
        self.viewModel = viewModel
        super.init(interactor: interactor, view: view)
        interactor.router = self
    }
}

extension BootstrapRouter: BootstrapRouting {
    func routeToRoot(component: BootstrapComponent) {
        let rootbuilder = RootBuilder(dependency: component)
        let router = rootbuilder.build()
        rootRouter = router
        interactor.show(rootView: router.view)
        router.activate()
        router.interactable.activate()
    }
}
