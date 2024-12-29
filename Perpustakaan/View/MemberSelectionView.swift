//
//  MemberSelectionView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//
import SwiftUI

struct MemberSelectionView: View {
    @ObservedObject var libraryViewModel: LibraryViewModel
    let book: Book
    @State private var selectedMemberId: Int? = nil
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode

    init(libraryViewModel: LibraryViewModel, book: Book) {
        self.libraryViewModel = libraryViewModel
        self.book = book
        _selectedMemberId = State(initialValue: libraryViewModel.members.first?.id)
    }

    var body: some View {
        VStack {
            Text("Select a Member")
                .font(.headline)
                .padding()

            Picker("Select a Member", selection: $selectedMemberId) {
                ForEach(libraryViewModel.members, id: \.id) { member in
                    Text(member.name)
                        .tag(member.id as Int?)
                }
            }
            .padding()
            .pickerStyle(WheelPickerStyle())

            Spacer()

            Button(action: {
                if selectedMemberId != nil {
                    showAlert = true
                }
            }) {
                Text("Borrow \(book.title)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedMemberId == nil ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            .disabled(selectedMemberId == nil)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Borrow Book"),
                    message: Text("Do you want to borrow \"\(book.title)\"?"),
                    primaryButton: .default(Text("Borrow")) {
                        if let memberId = selectedMemberId {
                            libraryViewModel.borrowBook(bookId: book.id, memberId: memberId)
                            presentationMode.wrappedValue.dismiss() 
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationTitle("Borrow Book")
    }
}
