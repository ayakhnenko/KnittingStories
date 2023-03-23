//
//  KnittingStoriesApp.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

@main
struct KnittingStoriesApp: App {
    
    let viewContext = DataController.shared.container.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
           
                .environment(\.managedObjectContext, viewContext)
        }
    }
}



