//
//  BusRow.swift
//  SwiftUI-5.5
//
//  Created by Joanna LINGENFELTER on 1/27/22.
//

import SwiftUI

struct BusRow: View {
    let bus: Bus
    let isFavorite: Bool
    
    var body: some View {
        HStack {
            AsyncImage(url: bus.image) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                default:
                    Image(systemName: "bus")
                }
            }
            .frame(width: 64, height: 64)
            .cornerRadius(5)
            
            VStack(alignment: .leading) {
                HStack{
                    if isFavorite {
                       Image(systemName: "heart.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom)
                            )
                    } else {
                        Image(systemName: "heart")
                    }
                    
                    Text(bus.name)
                        .font(.headline)
                }
                
                Text("*\(bus.location)* → *\(bus.destination)*")
                    .accessibilityLabel("Traveling from \(bus.location) to \(bus.destination)")
                    .font(.caption)
                
                HStack {
                    Image(systemName: "person.2.circle")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.green, .blue)
                    Text(String(bus.passengers))
                    Spacer(minLength: 10)
                    Image(systemName: "fuelpump.circle")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.green, .blue)
                    Text("\(bus.fuel)%")
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(bus.passengers) and \(bus.fuel) percent fuel")
            }
        }
    }
}

struct BusRow_Previews: PreviewProvider {
    static var previews: some View {
        BusRow(bus: Bus(id: 0, name: "", location: "", destination: "", passengers: 0, fuel: 0, image: URL(string:"")!), isFavorite: false)
    }
}
