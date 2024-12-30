//
//  LibraryViewModel.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//
import SwiftData
import Foundation
import SwiftUI

class LibraryViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext: ModelContext

    @Published var books: [Book] = []
    @Published var members: [anggota] = []
    @Published var loans: [Loan] = []

    init() {
        self.books = [
            Book(id: 1, title: "The Catcher in the Rye", author: "J.D. Salinger"),
            Book(id: 2, title: "To Kill a Mockingbird", author: "Harper Lee"),
            Book(id: 3, title: "1984", author: "George Orwell"),
            Book(id: 4, title: "Pride and Prejudice", author: "Jane Austen")
        ]
    
        self.members = [
            anggota(id: 1, name: "Budi Budiman", phone: "081213456782"),
            anggota(id: 2, name: "Andi Andika", phone: "089876543213"),
            anggota(id: 3, name: "Cak Sumanto", phone: "087654345678"),
            anggota(id: 4, name: "Denny Suharto", phone: "081234543234")
        ]
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        self.loans = [
            Loan(book: books[0], member: members[0], borrowDate: today, dueDate: Calendar.current.date(byAdding: .day, value: 7, to: today)!),
        ]
        
        for loan in loans {
            if let index = books.firstIndex(where: { $0.id == loan.book.id }) {
                books[index].isAvailable = false
            }
        }
    }


    func addBook(title: String, author: String) {
        let nextID = (books.map { $0.id }.max() ?? 0) + 1
        let book = Book(id: nextID, title: title, author: author, isAvailable: true)
        books.append(book)
        modelContext.insert(book)
        try? modelContext.save()
    }

    func addMember(name: String, phone: String) {
        let nextID = (members.map { $0.id }.max() ?? 0) + 1
        let member = anggota(id: nextID, name: name, phone: phone)
        members.append(member)
        modelContext.insert(member)
        try? modelContext.save()
    }

    func borrowBook(bookId: Int, memberId: Int) {
        guard let book = books.first(where: { $0.id == bookId && $0.isAvailable }) else {
            print("Book not available or does not exist.")
            return
        }
        guard let member = members.first(where: { $0.id == memberId }) else {
            print("Member does not exist.")
            return
        }
        
        let borrowDate = Date()
        let dueDate = Calendar.current.date(byAdding: .day, value: 7, to: borrowDate) ?? borrowDate
        
        let loan = Loan(book: book, member: member, borrowDate: borrowDate, dueDate: dueDate)
        loans.append(loan)
        
        book.isAvailable = false
        
        
        modelContext.insert(loan)
        try? modelContext.save()
    }
    
    func returnBook(loan: Loan) {
        if let book = books.first(where: { $0.id == loan.book.id }) {
            book.isAvailable = true
        }
        
        if let index = loans.firstIndex(where: { $0.id == loan.id }) {
            loans.remove(at: index)
        }
        
        try? modelContext.save()
    }
    
    func activeLoans() -> [Loan] {
        
        return loans.filter { $0.dueDate > Date() && !$0.book.isAvailable }
    }
    func dueText(for loan: Loan) -> (String, Color) {
        let daysLeft = Calendar.current.dateComponents([.day], from: Date(), to: loan.dueDate).day ?? 0
        let dueText: String
        let dueColor: Color
        
        if daysLeft > 0 {
            dueText = "\(daysLeft + 1) days left to return"
            dueColor = .green
        } else if daysLeft == 0 {
            dueText = "Due today"
            dueColor = .yellow
        } else {
            dueText = "Overdue by \(-daysLeft) days"
            dueColor = .red
        }
        
        return (dueText, dueColor)
    }
}
