//
//  DataController.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import Foundation
import CoreData



class DataController: ObservableObject {
    
   static let shared = DataController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "KnittingStories")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
                return
            }
            //self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

   
}
