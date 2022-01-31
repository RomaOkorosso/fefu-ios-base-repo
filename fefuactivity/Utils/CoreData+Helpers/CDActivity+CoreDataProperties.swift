//
//  CDActivity+CoreDataProperties.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 29.01.2022.
//

import Foundation
import CoreData

extension CDActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDActivity> {
        return NSFetchRequest<CDActivity>(entityName: "CDActivity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date
    @NSManaged public var type: String
    @NSManaged public var distance: String
    @NSManaged public var duration: String

}

extension CDActivity : Identifiable {

}
