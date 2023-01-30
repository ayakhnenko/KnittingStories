//
//  KnittingStoriesApp.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

@main
struct KnittingStoriesApp: App {
    
   
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
