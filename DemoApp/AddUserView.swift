//
//  AddUserView.swift
//  DemoApp
//
//  Created by Martin Mitrevski on 22.7.22.
//

import SwiftUI
import StreamVideo

struct AddUserView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var name = ""
    @State var id = ""
    @State var token = ""
    
    var body: some View {
        VStack {
            Text("Add a new user")
                .font(.title)
                .padding()
            
            TextField("User id", text: $id)
                .textFieldStyle(.roundedBorder)
                .padding(.all, 8)
            
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.all, 8)
            
            TextField("Token", text: $token)
                .textFieldStyle(.roundedBorder)
                .padding(.all, 8)
            
            Button {
                let userInfo = UserInfo(
                    id: id,
                    name: name,
                    imageURL: nil,
                    extraData: [:]
                )
                if let token = try? Token(rawValue: token) {
                    let user = UserCredentials(userInfo: userInfo, token: token)
                    mockUsers.append(user)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Add user")
                    .padding()
            }
            .foregroundColor(Color.white)
            .background(buttonDisabled ? Color.gray : Color.blue)
            .disabled(buttonDisabled)
            .cornerRadius(16)

            Spacer()
        }
    }
    
    private var buttonDisabled: Bool {
        name.isEmpty || id.isEmpty || token.isEmpty
    }
    
}