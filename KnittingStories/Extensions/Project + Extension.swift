//
//  Project + Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 16.02.2023.
//

import Foundation
import CoreData


extension Project {
    
    var additExpense: Double {
       cost + deliveryCost + comission
    }
    
    var margin: Double {
        saleCost - additExpense
    }
    
    var cost: Double {
        var cost = 0.0
        
        for i in yarnForProjectArray {
          cost += i.yarnWeightInProj * (i.fromYarn?.pricePer1g)!
        }
        return cost
    }
    
   
    public var yarnForProjectArray: [YarnProj] {
        let set = yarnForProject as? Set<YarnProj> ?? []
        return set.sorted { $0.yarnWeightInProj > $1.yarnWeightInProj }
    }
    

}

extension Project: BaseModel {
    
    static var all: NSFetchRequest<Project> {
        let request = Project.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
        return request
    }
    
    static var soldProjects: NSFetchRequest<Project> {
        let request = Project.fetchRequest()
        request.predicate = NSPredicate(format: "sold == true")
        request.sortDescriptors = [NSSortDescriptor(key: "saleDate", ascending: false)]
        return request
    }
    
    static var onSaleProjects: NSFetchRequest<Project> {
        let request = Project.fetchRequest()
        request.predicate = NSPredicate(format: "forSale == true")
        request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
        return request
    }
}
