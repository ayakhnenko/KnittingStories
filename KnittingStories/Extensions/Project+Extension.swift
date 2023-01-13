//
//  Project+Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 18.10.2022.
//

import Foundation


extension Project {
    
//    public var yarnsArray: [Yarn] {
//      let set = yarnForProject as? Set<Yarn> ?? []
//        return set.sorted {
//            $0.date! < $1.date!
//        }
//    }
    
//    public var yarnsProjArray: [YarnProj] {
//        let set = yarnForProject as? Set<YarnProj> ?? []
//        return set.sorted {
//            $0.yarnWeightInProj > $1.yarnWeightInProj
//        }
//    }
    
    var additExpense: Double {
       cost + deliveryCost + comission
    }
    
    var margin: Double {
        saleCost - additExpense
    }
    
    
}
