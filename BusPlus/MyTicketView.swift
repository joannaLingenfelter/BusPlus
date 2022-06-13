//
//  MyTicketView.swift
//  SwiftUI-5.5
//
//  Created by Joanna LINGENFELTER on 2/1/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

@MainActor // Always do this with observable classes!
class Ticket: ObservableObject {
    @Published var name: String
    @Published var reference: String
    
    var identifier: String {
        return name + reference
    }
    
    init(name: String = "", reference: String = "") {
        self.name = name
        self.reference = reference
    }
}

struct MyTicketView: View {
    enum Field {
        case name
        case reference
    }
    
    @EnvironmentObject var ticket: Ticket
    @FocusState private var focusedField: Field?
    
    // Don't do this in SwiftUI!
//    let context = CIContext()
//    let filter = CIFilter.qrCodeGenerator()
    
    @State private var context = CIContext()
    @State private var filter = CIFilter.qrCodeGenerator()
    
    private var qrCode: Image {
        let data = Data(ticket.identifier.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgimg)
                return Image(uiImage: uiImage)
            }
        }
        
        return Image(systemName: "xmark.circle")
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Johnny Appleseed", text: $ticket.name)
                    .focused($focusedField, equals: .name)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                    .submitLabel(.next)
    
                
                TextField("Ticket Reference Number", text: $ticket.reference)
                    .focused($focusedField, equals: .reference)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
                
                qrCode
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 250, height: 250)
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(.horizontal, 20)
            .onSubmit {
                switch focusedField {
                case .name:
                    focusedField = .reference
                default:
                    focusedField = nil
                }
            }
            .navigationTitle("Ticket Reference")
        }
    }
}

struct MyTicketView_Previews: PreviewProvider {
    static var previews: some View {
        MyTicketView()
    }
}
