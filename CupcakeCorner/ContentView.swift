//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 19/01/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderStore = OrderStore()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderStore.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(orderStore.order.quantity)", value: $orderStore.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderStore.order.specialRequestEnabled.animation())
                    
                    if orderStore.order.specialRequestEnabled {
                        Toggle("Add estra frosting", isOn: $orderStore.order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $orderStore.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderStore: orderStore)
                    } label: {
                        Text("Delivery details")
                    }
                }
                .disabled(orderStore.order.quantity < 1)
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
