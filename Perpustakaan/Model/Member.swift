//
//  Member.swift
//  Perpustakaan
//
//  Created by Trisha Alexis Likorawung on 29/12/24.
//

import Foundation
import SwiftData

@Model
class anggota {
    var id : Int
    var name: String
    var address: String
    
    init(id: Int, name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}
