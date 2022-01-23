//
//  Checkoutview.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 20/01/2022.
//

import SwiftUI

struct Checkoutview: View {
    @ObservedObject var orderStore: OrderStore
    @State private var confirmationMessage = ""
    let submitErrorMessage = "Hmm, something went wrong..."
    @State private var showingConfirmation = false
    @State private var showingNetworkError = false
    
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
                
                Text("Your total is \(orderStore.order.cost, format:  .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thanks you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Oops, something went wrong", isPresented: $showingNetworkError) {
            Button("OK") {}
        } message: {
            Text(submitErrorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderStore.order) else {
            print("Failed to encode order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodeOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodeOrder.quantity)x \(Order.types[decodeOrder.type]) cupcakes is no the way."
            showingConfirmation = true
        } catch  {
            print("Something went wrong: \(error)")
            showingNetworkError = true
        }
    }
}

struct Checkoutview_Previews: PreviewProvider {
    static var previews: some View {
        Checkoutview(orderStore: OrderStore())
    }
}
