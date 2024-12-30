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
    @State private var phone: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var isNameFocused: Bool
    @FocusState private var isPhoneFocused: Bool

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
            
            Text("Member Phone Number")
                .font(.headline)
                .padding()
            
            TextField("Member Phone Number", text: $phone)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .focused($isPhoneFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isPhoneFocused = false
                            isNameFocused = false
                        }
                    }
                }

            Button(action: {
                libraryViewModel.addMember(name: name, phone: phone)
                name = ""
                phone = ""
                showAlert = true
            }) {
                Text("Add Member")
            }
            .buttonStyle(AdminButtonStyle(color: .orange))
            .disabled(name.isEmpty || phone.isEmpty) 
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

