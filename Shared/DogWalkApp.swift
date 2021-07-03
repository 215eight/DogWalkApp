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

    private let bootstrapRouter: BootstrapRouting

    init() {
        let builder = BootstrapBuilder(dependency: EmptyComponent())
        bootstrapRouter = builder.build()
    }

    var body: some Scene {
        WindowGroup {
            bootstrapRouter.viewable.view
                .onAppear {
                    bootstrapRouter.activate()
                    bootstrapRouter.interactable.activate()
                }
        }
    }
}
