//
//  APIClient.swift
//  BusPlus
//
//  Created by Joanna Lingenfelter on 6/13/22.
//

import Foundation

class APIClient {
    func fetchBusses() async -> [Bus] {
        let url = URL(string: "https://hws.dev/bus-timetable")!
        do {
            let busses: [Bus] = try await URLSession.shared.decode(from: url)
            return busses
        } catch {
            print("Failed to fetch busses: \(error.localizedDescription)")
            return []
        }
    }
}
