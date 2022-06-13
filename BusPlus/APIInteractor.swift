//
//  APIInteractor.swift
//  BusPlus
//
//  Created by Joanna Lingenfelter on 6/13/22.
//

import Foundation

class APIInteractor {
    let state: AppState
    let api: APIClient

    init(api: APIClient, state: AppState) {
        self.api = api
        self.state = state
    }

    func fetchBusses() async {
        await state.busses = api.fetchBusses()
    }
}
