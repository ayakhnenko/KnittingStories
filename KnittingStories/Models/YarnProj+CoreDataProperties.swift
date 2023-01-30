//
//  YarnProj+CoreDataProperties.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.01.2023.
//
//

import Foundation
import CoreData


extension YarnProj: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<YarnProj> {
        return NSFetchRequest<YarnProj>(entityName: "YarnProj")
    }

    @NSManaged public var id: UUID
    @NSManaged public var yarnWeightInProj: Double
    @NSManaged public var fromProj: Project?
    @NSManaged public var fromYarn: Yarn?

}

//extension YarnProj : Identifiable {
//
//}
