//
//  PerpustakaanApp.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import SwiftUI
import SwiftData

@main
struct LibraryApp: App {
    var body: some Scene {
        WindowGroup {
            AdminDashboardView()
                .modelContainer(for: [Book.self, anggota.self, Loan.self]) 
        }
    }
}

