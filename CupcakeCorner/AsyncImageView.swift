//
//  AsyncImageView.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 19/01/2022.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            
            // With error handling
            AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error while loading the image")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
