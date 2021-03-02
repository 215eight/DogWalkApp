//
//  DogWalkApp.swift
//  DogWalkApp
//
//  Created on 2/16/21
//

import SwiftUI
import RIBs

@main
struct DogWalkApp: App {

    private let bootstrapRouter: BootstrapRouter

    init() {
        let builder = BootstrapBuilder(dependency: EmptyComponent())
        bootstrapRouter = builder.build()
    }

    var body: some Scene {
        WindowGroup {
            bootstrapRouter.view
                .onAppear {
                    bootstrapRouter.activate()
                    bootstrapRouter.interactable.activate()
                }
        }
    }
}
