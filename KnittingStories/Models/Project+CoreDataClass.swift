//
//  Project+CoreDataClass.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.01.2023.
//
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {

    
}

extension Project {
    
    var additExpense: Double {
       cost + deliveryCost + comission
    }
    
    var margin: Double {
        saleCost - additExpense
    }
    
    
}
