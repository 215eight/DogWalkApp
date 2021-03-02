//
//  RootView.swift
//  DogWalkApp
//
//  Created on 2/17/21
//

import Foundation
import SwiftUI
import DogWalkService
import RIBs

final class RootViewModel: ObservableObject {
    @Published var dogs = [Dog]()
    @Published var selectedDog: Dog?
}

struct RootView: View {

    @State var showAddDog = false

    @ObservedObject private var viewModel: RootViewModel

    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.dogs, rowContent: { dog in
            Text(dog.name)
                .onTapGesture {
                    viewModel.selectedDog = dog
                }
        })
        .navigationTitle("Doggos")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    showAddDog = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
        }
    }
}
