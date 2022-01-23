//
//  OrderStore.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 23/01/2022.
//

import Foundation

class OrderStore: ObservableObject {
    @Published var order: Order
    
    init() {
        self.order = Order()
    }
}
