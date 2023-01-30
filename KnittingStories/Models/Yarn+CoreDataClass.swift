//
//  Yarn+CoreDataClass.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.01.2023.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Yarn)
public class Yarn: NSManagedObject, Identifiable {
   
    
   
}

extension Yarn {
    public var wrappedName: String {
        name ?? "Назва пряжі"
        
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
