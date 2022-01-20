//
//  Checkoutview.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 20/01/2022.
//

import SwiftUI

struct Checkoutview: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format:  .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Checkoutview_Previews: PreviewProvider {
    static var previews: some View {
        Checkoutview(order: Order())
    }
}
