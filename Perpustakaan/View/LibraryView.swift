//
//  LibraryView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var libraryViewModel: LibraryViewModel
    
    var body: some View {
        NavigationStack {
            List(libraryViewModel.books, id: \ .id) { book in
                NavigationLink(destination: MemberSelectionView(libraryViewModel: libraryViewModel, book: book)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text("by \(book.author)")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(book.isAvailable ? "Available" : "Not Available")
                            .foregroundColor(book.isAvailable ? .green : .red)
                    }
                }
                .disabled(!book.isAvailable)
            }
            .navigationTitle("Library Catalog")
        }
    }
}
