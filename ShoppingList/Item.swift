//
//  Item.swift
//  ShoppingList
//
//  Created by Andreas Amundsen on 30/10/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
