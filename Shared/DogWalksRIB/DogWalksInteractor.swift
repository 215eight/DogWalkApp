//
//  DogWalksInteractor.swift
//  DogWalkApp
//
//  Created on 2/19/21
//

import Foundation
import RIBs
import DogWalkService

protocol DogWalksListener: AnyObject {
    func dismiss(_ router: DogWalksRouter)
}

protocol DogWalksInteractable: Interactable {
    var  listener: DogWalksListener? { get set }
    var router: DogWalksRouter? { get set }
}

final class DogWalksInteractor: ViewableInteractor<DogWalksViewModel> {
    private let dogWalkService: DogWalkServicing
    weak var listener: DogWalksListener?
    weak var router: DogWalksRouter?

    init(controllable: DogWalksViewModel,
         dogWalkService: DogWalkServicing) {
        self.dogWalkService = dogWalkService
        super.init(viewModel: controllable)
    }
    override func didBecomeActive() {
        super.didBecomeActive()
        dogWalkService.fetchWalks(dogId: viewModel.dog.id)
            .sink(receiveValue: { walks in
                self.viewModel.walks = walks
            }, receiveError: { _ in
            })
            .cancelOnDeactivate(interactor: self)

        viewModel.$dismiss
            .compactMap { $0 }
            .sink(receiveValue: { _ in
                guard let router = self.router else { return }
                self.listener?.dismiss(router)
            })
            .cancelOnDeactivate(interactor: self)
    }
}

extension DogWalksInteractor: DogWalksInteractable {}
