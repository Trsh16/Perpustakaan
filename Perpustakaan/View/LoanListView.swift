//
//  LoanListView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import SwiftUI

struct LoanListView: View {
    @ObservedObject var libraryViewModel: LibraryViewModel
    @State private var showReturnAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var selectedLoan: Loan?

    var body: some View {
        List(libraryViewModel.activeLoans(), id: \.borrowDate) { loan in
            HStack{
                VStack(alignment: .leading) {
                    Text("Book: \(loan.book.title)")
                        .font(.subheadline)
                    Text("Borrowed by: \(loan.member.name)")
                        .font(.footnote)
                    
                    Text("Due Date: \(loan.dueDate, style: .date)")
                        .font(.footnote)
                        .foregroundColor(.red)
                    Text("Borrow Date: \(loan.borrowDate, style: .date)")
                        .font(.footnote)
                        .foregroundColor(.blue)
                    let (dueText, dueColor) = libraryViewModel.dueText(for: loan)
                    Text(dueText)
                        .font(.footnote)
                        .foregroundColor(dueColor)
                }
                Spacer()
                if !loan.book.isAvailable {
                    Button(action: {
                        selectedLoan = loan
                        showReturnAlert = true
                        alertMessage = "Is the book \"\(loan.book.title)\" already returned?"
                    }) {
                        Text("Return")
                            .padding(5)
                            .font(.footnote)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
            }
            .padding()
        }
        .navigationTitle("Book Loans")
        .alert(isPresented: $showReturnAlert) {
            Alert(
                title: Text("Return Book"),
                message: Text(alertMessage),
                primaryButton: .destructive(Text("Yes")) {
                    if let loan = selectedLoan {
                        libraryViewModel.returnBook(loan: loan)
                    }
                },
                secondaryButton: .cancel(Text("No")) {
                    
                }
            )
        }
    }
}
