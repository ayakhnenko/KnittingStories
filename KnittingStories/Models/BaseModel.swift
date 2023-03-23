//
//  BaseModel.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 14.02.2023.
//

import Foundation
import CoreData


protocol BaseModel {
    
    static var viewContext: NSManagedObjectContext { get }
    
    func save() throws
    
    func delete() throws
}

extension BaseModel where Self: NSManagedObject {
    
    static var viewContext: NSManagedObjectContext {
        DataController.shared.container.viewContext
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try save()
    }
}
