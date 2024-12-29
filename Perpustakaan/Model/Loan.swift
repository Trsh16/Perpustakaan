//
//  Loan.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//
import Foundation
import SwiftData

@Model
class Loan {
    var book: Book
    var member: anggota
    var borrowDate: Date
    var dueDate: Date

    init(book: Book, member: anggota, borrowDate: Date, dueDate: Date) {
        self.book = book
        self.member = member
        self.borrowDate = borrowDate
        self.dueDate = dueDate
    }
}
