//
//  Bus.swift
//  SwiftUI-5.5
//
//  Created by Joanna LINGENFELTER on 1/27/22.
//

import Foundation

struct Bus: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let location: String
    let destination: String
    let passengers: Int
    let fuel: Int
    let image: URL
}
