//
//  DogWalkView.swift
//  DogWalkApp
//
//  Created on 2/19/21
//

import Foundation
import DogWalkService
import SwiftUI

final class DogWalksViewModel: ObservableObject {
    @Published var dog: Dog
    @Published var walks = [Walk]()
    @Published var dismiss: Void?

    init(dog: Dog) {
        self.dog = dog
    }
}

struct DogWalksView: View {

    @ObservedObject private var viewModel: DogWalksViewModel

    init(viewModel: DogWalksViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.walks, rowContent: { walk in
            Text(walk.date.description)
        })
        .navigationTitle(viewModel.dog.name)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.dismiss = ()
                }, label: {
                    Image(systemName: "chevron.left")
                })
            }
        }
    }
}
