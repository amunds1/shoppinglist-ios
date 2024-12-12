//
//  PreviewSampleData.swift
//  ShoppingList
//
//  Created by Andreas Amundsen on 04/11/2024.
//

import SwiftData
import SwiftUI

@MainActor
let previewContainer: ModelContainer = {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)
    
    for item in Utils.shopplingListExampleItems {
        container.mainContext.insert(item)
    }
    
    return container
}()


