//
//  Yarn+CoreDataProperties.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.01.2023.
//
//

import Foundation
import CoreData


extension Yarn {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Yarn> {
        return NSFetchRequest<Yarn>(entityName: "Yarn")
    }

    @NSManaged public var color: String?
    @NSManaged public var compound: String?
    @NSManaged public var date: Date?
    @NSManaged public var deliveryPrice: Double
    @NSManaged public var footagePer100g: Double
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var originalWeight: Double
    @NSManaged public var pricePer100g: Double
    @NSManaged public var shop: String?
    @NSManaged public var isArchived: Bool
    @NSManaged public var yarnWeight: NSSet?
    

    public var yarnWeightArray: [YarnProj] {
        let set = yarnWeight as? Set<YarnProj> ?? []
        return set.sorted { $0.yarnWeightInProj < $1.yarnWeightInProj }
    }
}

// MARK: Generated accessors for yarnWeight
extension Yarn {

    @objc(addYarnWeightObject:)
    @NSManaged public func addToYarnWeight(_ value: YarnProj)

    @objc(removeYarnWeightObject:)
    @NSManaged public func removeFromYarnWeight(_ value: YarnProj)

    @objc(addYarnWeight:)
    @NSManaged public func addToYarnWeight(_ values: NSSet)

    @objc(removeYarnWeight:)
    @NSManaged public func removeFromYarnWeight(_ values: NSSet)

}

//extension Yarn : Identifiable {
//
//}
