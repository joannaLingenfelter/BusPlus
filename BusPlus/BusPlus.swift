//
//  SwiftUI_5_5App.swift
//  SwiftUI-5.5
//
//  Created by Joanna LINGENFELTER on 1/27/22.
//

import SwiftUI

@main
struct BusPlus: App {
    @StateObject private var ticket = Ticket()
    @StateObject var context: AppContext

    init() {
        let state = AppState()
        _context = StateObject(wrappedValue: AppContext(state: state, api: APIInteractor(api: APIClient(), state: state)))
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                BusListView(context: context)
                    .tabItem {
                        Label("Busses", systemImage: "bus")
                    }
                
                MyTicketView()
                    .tabItem {
                        Label("My Ticket", systemImage: "qrcode")
                    }
                    .badge(ticket.identifier.isEmpty ? "!" : nil)
            }
            .environmentObject(ticket)
        }
    }
}
