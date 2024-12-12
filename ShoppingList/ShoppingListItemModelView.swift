//
//  ShoppingListItem.swift
//  ShoppingList
//
//  Created by Andreas Amundsen on 30/10/2024.
//

import SwiftUI

struct ShoppingListItemModelView: View {
    let item: Item
    
    var iconImage: String {
        item.checked ? "checkmark.circle.fill" : "circle"
    }
    
    var iconColor: Color {
        item.checked ? .green : .primary
    }

    var body: some View {
        Button(action: {
            withAnimation {
                item.checked.toggle()
            }
        }) {
            HStack {
                Image(systemName: iconImage)
                    .foregroundStyle(iconColor)
                    .font(.title3)
                    .padding(.trailing, 5)
                Text(item.name)
                    .strikethrough(item.checked)
            }
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    ShoppingListItemModelView(item: Item(name: "Bananer"))
}
