//
//  AppContext.swift
//  BusPlus
//
//  Created by Joanna Lingenfelter on 6/13/22.
//

import Foundation

class AppContext: ObservableObject {
    let state: AppState
    let api: APIInteractor

    init(state: AppState, api: APIInteractor) {
        self.state = state
        self.api = api
    }
}
