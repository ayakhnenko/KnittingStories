//
//  DataController.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import Foundation
import CoreData
import UIKit

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "KnittingStories")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data save")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addYarn(name: String, image: UIImage, compound: String, footagePer100g: Double, pricePer100g: Double, deliveryPrice: Double, color: String, shop: String, date: Date, originalWeight: Double, context: NSManagedObjectContext ) {
        
        let yarn = Yarn(context: context)
        
        yarn.name = name
        yarn.id = UUID()
        yarn.image = image.pngData()
        yarn.compound = compound
        yarn.footagePer100g = footagePer100g
        yarn.pricePer100g = pricePer100g
        yarn.deliveryPrice = deliveryPrice
        yarn.color = color
        yarn.shop = shop
        yarn.date = date
        yarn.originalWeight = originalWeight
        
        
        save(context: context)
        
    }
    
    func editYarn(yarn: Yarn, name: String, image: UIImage, compound: String, footagePer100g: Double, pricePer100g: Double, deliveryPrice: Double, color: String, shop: String, date: Date, originalWeight: Double, context: NSManagedObjectContext ) {
        yarn.name = name
        yarn.image = image.pngData()
        yarn.compound = compound
        yarn.footagePer100g = footagePer100g
        yarn.pricePer100g = pricePer100g
        yarn.deliveryPrice = deliveryPrice
        yarn.color = color
        yarn.shop = shop
        yarn.date = date
        yarn.originalWeight = originalWeight
        
        save(context: context)
    }
    
   
    func addYarnProj(fromYarn: Yarn, yarnWeightInProj: Double, context: NSManagedObjectContext) {
        let yarnProj = YarnProj(context: context)
        yarnProj.id = UUID()
        yarnProj.fromYarn = fromYarn
        yarnProj.yarnWeightInProj = yarnWeightInProj
        save(context: context)
       
    }
    
   
    func addProject(name: String, image: UIImage, totalWeight: Double, startDate: Date, finishDate: Date, forSale: Bool, sold: Bool, size: String, needlesNumber: Int16, marketplace: String, saleDate: Date, comission: Double, deliveryCost: Double, saleCost: Double, yarnsProjArray: [YarnProj], context: NSManagedObjectContext) {
        
        let project = Project(context: context)
        
        project.name = name
        project.id = UUID()
        project.image = image.pngData()
        project.totalWeight = totalWeight
        project.size = size
        project.startDate = startDate
        project.finishDate = finishDate
        project.marketplace = marketplace
        project.forSale = forSale
        project.sold = sold
        project.needlesNumber = needlesNumber
        project.saleDate = saleDate
        project.comission = comission
        project.deliveryCost = deliveryCost
        project.saleCost = saleCost
       
        
       let uniqueYarnProj = Set(yarnsProjArray)
        for yarnProj in uniqueYarnProj {
            project.addToYarnForProject(yarnProj)
        }

        save(context: context)
    
//        let uniqueYarn = Set(yarnsArray)
//        for yarn in uniqueYarn {
//            project.addToYarnForProject(yarn)
//        }
     
    }
    
    func editProject(project: Project, name: String, image: UIImage, totalWeight: Double, startDate: Date, finishDate: Date, forSale: Bool, sold: Bool, size: String, needlesNumber: Int16, marketplace: String, saleDate: Date, comission: Double, deliveryCost: Double, saleCost: Double, yarnProjArray: [YarnProj], context: NSManagedObjectContext) {
        project.name = name
        project.image = image.pngData()
        project.totalWeight = totalWeight
        project.startDate = startDate
        project.finishDate = finishDate
        project.forSale = forSale
        project.sold = sold
        project.size = size
        project.needlesNumber = needlesNumber
        project.marketplace = marketplace
        project.saleDate = saleDate
        project.comission = comission
        project.deliveryCost = deliveryCost
        project.saleCost = saleCost
       
     
        
        save(context: context)
    }
    
  
}
