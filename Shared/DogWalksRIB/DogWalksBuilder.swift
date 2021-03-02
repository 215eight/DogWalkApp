//
//  DogWalksBuilder.swift
//  DogWalkApp
//
//  Created on 2/19/21
//

import Foundation
import RIBs
import DogWalkService

protocol DogWalksDependency {
    var dogWalkService: DogWalkServicing { get }
}

final class DogWalksComponent: Component<DogWalksDependency> {
    
}

protocol DogWalksBuilding: Buildable {
    associatedtype RouterType: DogWalksRouting
    func build(dog: Dog, listener: DogWalksListener) -> RouterType
}

final class DogWalksBuilder: Builder<DogWalksDependency>, DogWalksBuilding {

    func build(dog: Dog, listener: DogWalksListener) -> DogWalksRouter {
        let component = DogWalksComponent(dependency: dependency)
        let viewModel = DogWalksViewModel(dog: dog)
        let view = DogWalksView(viewModel: viewModel)
        let presentationViewModel = DogWalksPresentationViewModel()
        let presentationView = DogWalksPresentationView(viewModel: presentationViewModel, dogWalksView: view)
        let interactor = DogWalksInteractor(controllable: viewModel, dogWalkService: component.dependency.dogWalkService)
        interactor.listener = listener
        let router = DogWalksRouter(interactor: interactor, view: presentationView)
        return router
    }
}
