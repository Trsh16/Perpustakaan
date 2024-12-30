//
//  AddBookView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import SwiftUI

struct AddBookView: View {
    @ObservedObject var libraryViewModel: LibraryViewModel
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var isBookFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Book Title")
                .font(.headline)
                .padding()

            TextField("Book Title", text: $title)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .focused($isBookFocused)
            
            Text("Author Name")
                .font(.headline)
                .padding()
            
            TextField("Author Name", text: $author)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                libraryViewModel.addBook(title: title, author: author)
                title = ""
                author = ""
                showAlert = true
            }) {
                Text("Add Book")
            }
            .buttonStyle(AdminButtonStyle(color: .orange))
            .disabled(title.isEmpty || author.isEmpty) 
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Add Book")
        .alert("Book Added", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The book has been successfully added to the library.")
        }
    }
}
