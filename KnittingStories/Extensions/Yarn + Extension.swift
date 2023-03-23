//
//  Yarn + Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 14.02.2023.
//

import Foundation
import CoreData

extension Yarn {
    
    public var yarnWeightArray: [YarnProj] {
        let set = yarnWeight as? Set<YarnProj> ?? []
        return set.sorted { $0.yarnWeightInProj < $1.yarnWeightInProj }
    }
    public var wrappedName: String {
        name ?? "Назва пряжі"
        
    }
    func calcCurrentWeight() -> Double {
        var sum = 0.0
        for i in yarnWeightArray {
            sum += i.yarnWeightInProj
        }
        let currentWeight = originalWeight - sum
        return currentWeight
    }
    
    var totalExpense: Double {
        (pricePer100g / 100 * originalWeight) + deliveryPrice
    }
    var pricePer1g: Double {
        totalExpense / originalWeight
        
    }
}

extension Yarn: BaseModel {
    
    static var all: NSFetchRequest<Yarn> {
        let request = Yarn.fetchRequest()
        //request.predicate = NSPredicate(format: "isArchived == false")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
    
    static var isArchivedYarn: NSFetchRequest<Yarn> {
        let request = Yarn.fetchRequest()
        request.predicate = NSPredicate(format: "isArchived == true")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        return request
    }
    static var inStock: NSFetchRequest<Yarn> {
        let request = Yarn.fetchRequest()
        request.predicate = NSPredicate(format: "isArchived == false")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
}
