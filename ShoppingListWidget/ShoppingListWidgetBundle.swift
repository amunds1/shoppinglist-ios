//
//  ShoppingListWidgetBundle.swift
//  ShoppingListWidget
//
//  Created by Andreas Amundsen on 12/12/2024.
//

import WidgetKit
import SwiftUI

@main
struct ShoppingListWidgetBundle: WidgetBundle {
    var body: some Widget {
        ShoppingListWidget()
        ShoppingListWidgetControl()
    }
}
