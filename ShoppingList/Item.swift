//
//  Item.swift
//  ShoppingList
//
//  Created by Andreas Amundsen on 30/10/2024.
//

import Foundation
import SwiftData

@Model
final class Item: Identifiable {
    private(set) var id: UUID = UUID()
    private(set) var createdAt: Date
    
    var name: String
    var checked: Bool
    
    init(id: UUID = UUID(), createdAt: Date = .now, name: String, checked: Bool = false) {
        self.id = id
        self.createdAt = createdAt
        self.name = name
        self.checked = checked
    }
}
