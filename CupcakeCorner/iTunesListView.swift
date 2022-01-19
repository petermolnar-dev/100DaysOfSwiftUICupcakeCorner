//
//  iTunesListView.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 19/01/2022.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct iTunesListView: View {
    
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            print("Start downloading data")
            let (data, _) = try await URLSession.shared.data(from: url)
            print("We have the data!")
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch  {
            print("Invalid data")
        }
    }
}

struct iTunesListView_Previews: PreviewProvider {
    static var previews: some View {
        iTunesListView()
    }
}
