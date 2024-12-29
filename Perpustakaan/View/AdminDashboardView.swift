//
//  AdminDashboardView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//
import SwiftUI

struct AdminDashboardView: View {
    @StateObject private var libraryViewModel = LibraryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                NavigationLink("View Library Catalog", destination: LibraryView(libraryViewModel: libraryViewModel))
                    .buttonStyle(AdminButtonStyle(color: .orange))
                
                NavigationLink("View Members", destination: ViewMemberView(libraryViewModel: libraryViewModel))
                    .buttonStyle(AdminButtonStyle(color: .orange))
                
                NavigationLink("View Active Loans", destination: LoanListView(libraryViewModel: libraryViewModel))
                    .buttonStyle(AdminButtonStyle(color: .orange))
                
                NavigationLink("Add New Book", destination: AddBookView(libraryViewModel: libraryViewModel))
                    .buttonStyle(AdminButtonStyle(color: .orange))
                
                NavigationLink("Add New Member", destination: AddMemberView(libraryViewModel: libraryViewModel))
                    .buttonStyle(AdminButtonStyle(color: .orange))
                
                Spacer()
            }
            .padding()
            .navigationTitle("Library Admin")
        }
    }
}

#Preview {
    AdminDashboardView()
        .modelContainer(for: [Book.self, anggota.self, Loan.self]) 
}
