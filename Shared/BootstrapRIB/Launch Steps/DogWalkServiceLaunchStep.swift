//
//  DogWalkServiceLaunchStep.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import RIBs
import DogWalkService

struct DogWalkServiceLaunchStep: SynchronousApplicationLaunchStep {

    struct Error: Swift.Error {
        let message: String
    }

    func execute(input: ()) -> Result<DogWalkServicing, Error> {
        let dogWalkService = DogWalkService()
        switch dogWalkService.load() {
        case .success:
            return .success(dogWalkService)
        case .failure:
            return .failure(Error(message: "Unable to execute DogWalkService step"))
        }
    }
}
