//
//  ContentView.swift
//  ShoppingList
//
//  Created by Andreas Amundsen on 30/10/2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.createdAt) private var items: [Item]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var newItem: String = ""
    @State private var showAlert = false

    var body: some View {
        let uncheckedItems = items.filter { !$0.checked }
        let checkedItems = items.filter { $0.checked }
        
        NavigationStack {
            HStack {
                TextField("New item", text: $newItem)
                    .foregroundStyle(.secondary)
                    .onSubmit {
                        addItem(name: newItem)
                        newItem = ""
                    }
                    .disableAutocorrection(true)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    
                Button(action: {
                    addItem(name: newItem)
                    newItem = ""
                }) {
                    Label("Add", systemImage: "plus")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            List {
                ForEach(uncheckedItems) { item in
                    ShoppingListItemModelView(item: item)
                }
                .onDelete(perform: deleteItems)
                
                ForEach(checkedItems) { item in
                    ShoppingListItemModelView(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            //.scrollDismissKeyboard(.immediately)
            
            .navigationTitle("My shopping list")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAlert = true
                        
                    }) {
                        Label("Clear", systemImage: "trash")
                    }
                }
            }
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete all items"),
                    message: Text("Are you sure you want to delete all items?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteItems(offsets: IndexSet(items.indices))
                    },
                    secondaryButton: .cancel()
                )
            }
            .onChange(of: scenePhase) {
                if scenePhase == ScenePhase.background {
                    print("App is now active")
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
    }
    
    private func addItem(name: String) {
        if (name.isEmpty) {
            return
        }
        
        let newItem = Item(name: name)
        modelContext.insert(newItem)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving item: \(error)")
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error deleting item: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
