//
//  Buttonstyle.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//
import SwiftUI

struct AdminButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 90)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
