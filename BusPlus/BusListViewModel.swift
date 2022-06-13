//
//  BusListViewModel.swift
//  SwiftUI-5.5
//
//  Created by Joanna Lingenfelter on 6/13/22.
//

import Foundation
import Combine

extension BusListView {

    @MainActor
    class ViewModel: ObservableObject {
        @Published var busses = [Bus]()
        @Published var favorites = Set<Bus>()
        @Published var search = ""
        @Published var selectedBus: Bus?

        private var subscriptions = Set<AnyCancellable>()
        private let context: AppContext
        private let filteringQueue = DispatchQueue(label: "BusListView-Filtering")

        init(context: AppContext) {
            self.context = context

            Publishers.CombineLatest(context.state.$busses, $search)
                .receive(on: filteringQueue)
                .map { (busses, search) -> [Bus] in
                    if search.isEmpty {
                        return busses
                    } else {
                        return busses.filter {
                            return $0.name.localizedCaseInsensitiveContains(search)
                            || $0.location.localizedCaseInsensitiveContains(search)
                            || $0.destination.localizedCaseInsensitiveContains(search)
                        }
                    }
                }
                .receive(on: DispatchQueue.main)
                .assign(to: \.busses, on: self)
                .store(in: &subscriptions)
        }

        func fetchBusses() async {
            await context.api.fetchBusses()
        }
    }
}
