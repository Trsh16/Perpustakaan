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
    var bookToEdit: Book?

    init(libraryViewModel: LibraryViewModel, bookToEdit: Book? = nil) {
        self.libraryViewModel = libraryViewModel
        self.bookToEdit = bookToEdit
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(bookToEdit == nil ? "Book Title" : "Edit Book Title")
                .font(.headline)
                .padding()

            TextField("Book Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Author Name")
                .font(.headline)
                .padding()

            TextField("Author Name", text: $author)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if let bookToEdit = bookToEdit {
                    libraryViewModel.updateBook(bookToEdit, title: title, author: author)
                } else {
                    libraryViewModel.addBook(title: title, author: author)
                }
                title = ""
                author = ""
                showAlert = true
            }) {
                Text(bookToEdit == nil ? "Add Book" : "Save Changes")
            }
            .buttonStyle(AdminButtonStyle(color: .orange))
            .padding()
            .alert("Book Added", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The book has been successfully \(bookToEdit == nil ? "added" : "updated") to the library.")
            }
        }
        .onAppear {
            if let bookToEdit = bookToEdit {
                title = bookToEdit.title
                author = bookToEdit.author
            }
        }
        Spacer()
    }
}
