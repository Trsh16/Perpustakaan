//
//  ViewMemberView.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import SwiftUI

struct ViewMemberView: View {
    @ObservedObject var libraryViewModel: LibraryViewModel

    var body: some View {
        VStack {
            List(libraryViewModel.members) { member in
                VStack(alignment: .leading) {
                    Text(member.name)
                        .font(.headline)
                    Text("Phone Number: \(member.phone)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .navigationTitle("Library Members")
    }
}
