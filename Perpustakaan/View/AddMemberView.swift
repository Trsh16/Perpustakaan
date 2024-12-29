//
//  AddMemberView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//
import SwiftUI

struct AddMemberView: View {
    @ObservedObject var libraryViewModel: LibraryViewModel
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var isNameFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Member Name")
                .font(.headline)
                .padding()
            
            TextField("Member Name", text: $name)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .focused($isNameFocused)
            
            Text("Member Address")
                .font(.headline)
                .padding()
            
            TextField("Member Address", text: $address)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                libraryViewModel.addMember(name: name, address: address)
                name = ""
                address = ""
                showAlert = true
            }) {
                Text("Add Member")
            }
            .buttonStyle(AdminButtonStyle(color: .orange))
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Add Member")
        .alert("Member Added", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The member has been successfully added to the library.")
        }
        .onAppear {
            isNameFocused = true
        }
    }
}
