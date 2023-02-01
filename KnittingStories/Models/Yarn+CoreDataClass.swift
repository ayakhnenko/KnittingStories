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

   
    
//    public enum Error: String {
//
//        case Image = "Choose image"
//        case Color = "Choose color"
//        case Compound = "Choose compound"
//        case Date = "Choose date"
//        case Shop = "Choose shop"
//        case Name = "Choose name"
//
//    }
}
