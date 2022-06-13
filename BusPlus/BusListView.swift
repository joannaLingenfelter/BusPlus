//
//  ContentView.swift
//  SwiftUI-5.5
//
//  Created by Joanna LINGENFELTER on 1/27/22.
//

import SwiftUI

struct BusListView: View {
    @StateObject var viewModel: ViewModel

    init(context: AppContext) {
        _viewModel = StateObject(wrappedValue: ViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.busses) { bus in
                    BusRow(bus: bus, isFavorite: viewModel.favorites.contains(bus))
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                toggle(favorite: bus)
                                print("\(bus.name) is now a favorite!")
                            } label: {
                                if viewModel.favorites.contains(bus) {
                                    Label("Remove Favorite", systemImage: "heart.slash")
                                } else {
                                    Label("Add Favorite", systemImage: "heart")
                                }
                            }
                            .tint(.mint)
                        }
                        .onTapGesture {
                            self.viewModel.selectedBus = bus
                        }
                
            }
            
                if let selectedBus = viewModel.selectedBus {
                    AsyncImage(url: selectedBus.image) { image in
                        image.resizable()
                            .cornerRadius(10)
                    } placeholder: {
                        Image(systemName: "bus")
                    }
                    .frame(width: 275, height: 275)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .onTapGesture {
                        self.viewModel.selectedBus = nil
                    }
                }
            }
            .navigationTitle("Bus+")
            .task {
                if viewModel.busses.isEmpty {
                    await viewModel.fetchBusses()
                }
            }
            .refreshable {
                await viewModel.fetchBusses()
            }
            .searchable(text: $viewModel.search.animation(), prompt: "Filter Busses") {
                ForEach(viewModel.busses) { (result: Bus) in
                    Text(result.name).searchCompletion(result.name)
                }
            }
                
        }
    }
    
    func toggle(favorite bus: Bus) {
        if viewModel.favorites.contains(bus) {
            viewModel.favorites.remove(bus)
        } else {
            viewModel.favorites.insert(bus)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusListView()
//    }
//}
