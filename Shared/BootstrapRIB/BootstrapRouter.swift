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

final class BootstrapRouter: ViewableRouter<BootstrapInteractable, BootstrapPresentationViewModel> {

    private var rootRouter: RootRouting?

    override init(interactor: BootstrapInteractable,
                  viewModel: BootstrapPresentationViewModel,
                  viewable: Viewable) {
        super.init(interactor: interactor, viewModel: viewModel, viewable: viewable)
        interactor.router = self
    }
}

extension BootstrapRouter: BootstrapRouting {
    func routeToRoot(component: BootstrapComponent) {
        let rootbuilder = RootBuilder(dependency: component)
        let router = rootbuilder.build()
        rootRouter = router
        interactor.show(rootView: router.viewable)
        router.activate()
        router.interactable.activate()
    }
}
