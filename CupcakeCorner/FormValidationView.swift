//
//  FormValidationView.swift
//  CupcakeCorner
//
//  Created by Peter Molnar on 19/01/2022.
//

import SwiftUI

struct FormValidationView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account")
                }
            }
            .disabled(disableForm)
            // Pay attention: the disabled is on the Section!
        }
    }
}

struct FormValidationView_Previews: PreviewProvider {
    static var previews: some View {
        FormValidationView()
    }
}
