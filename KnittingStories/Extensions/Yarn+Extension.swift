//
//  Yarn+Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import Foundation


extension Yarn {
    
   
    
//    public var projectsArray: [Project] {
//        let set = projectFromYarn as? Set<Project> ?? []
//        return set.sorted { $0.name! <  $1.name!
//        }
//    }
//
    public var yarnWeightArray: [YarnProj] {
        let set = yarnWeight as? Set<YarnProj> ?? []
        return set.sorted { $0.id < $1.id

        }
    }
    var totalExpense: Double {
        (pricePer100g / 100 * originalWeight) + deliveryPrice
    }
    var pricePer1g: Double {
        totalExpense / originalWeight
    
    }

    var currentWeight: Double {
        originalWeight 
    }
}
