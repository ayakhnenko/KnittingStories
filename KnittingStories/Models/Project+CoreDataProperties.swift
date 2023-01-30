//
//  Project+CoreDataProperties.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.01.2023.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var additExpenses: Double
    @NSManaged public var comission: Double
    @NSManaged public var comments: String?
    @NSManaged public var cost: Double
    @NSManaged public var deliveryCost: Double
    @NSManaged public var finishDate: Date?
    @NSManaged public var forSale: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var marketplace: String?
    @NSManaged public var name: String?
    @NSManaged public var needlesNumber: Int16
    @NSManaged public var saleCost: Double
    @NSManaged public var saleDate: Date?
    @NSManaged public var size: String?
    @NSManaged public var sold: Bool
    @NSManaged public var startDate: Date?
    @NSManaged public var totalWeight: Double
    @NSManaged public var yarnForProject: NSSet?
    
    public var wrappedName: String {
        name ?? "Назва проекту"
    }
    
   
    public var yarnForProjectArray: [YarnProj] {
        let set = yarnForProject as? Set<YarnProj> ?? []
        return set.sorted { $0.yarnWeightInProj > $1.yarnWeightInProj }
    }

}

// MARK: Generated accessors for yarnForProject
extension Project {

    @objc(addYarnForProjectObject:)
    @NSManaged public func addToYarnForProject(_ value: YarnProj)

    @objc(removeYarnForProjectObject:)
    @NSManaged public func removeFromYarnForProject(_ value: YarnProj)

    @objc(addYarnForProject:)
    @NSManaged public func addToYarnForProject(_ values: NSSet)

    @objc(removeYarnForProject:)
    @NSManaged public func removeFromYarnForProject(_ values: NSSet)

}

extension Project : Identifiable {

}
