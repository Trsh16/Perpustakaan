//
//  Book.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import SwiftData
import Foundation

@Model
class Book {
    var id: Int
    var title: String
    var author: String
    var isAvailable: Bool

    init(id: Int, title: String, author: String, isAvailable: Bool = true) {
        self.id = id
        self.title = title
        self.author = author
        self.isAvailable = isAvailable
    }
}
