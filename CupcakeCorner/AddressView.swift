//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 20/01/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderStore: OrderStore
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderStore.order.name)
                TextField("Street Address", text: $orderStore.order.streetAddress)
                TextField("City", text: $orderStore.order.city)
                TextField("Zip", text: $orderStore.order.zip)

            }
            
            Section {
                NavigationLink {
                    Checkoutview(orderStore: orderStore)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderStore.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderStore: OrderStore())
    }
}
