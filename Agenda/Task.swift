//
//  Task.swift
//  Agenda
//
//  Created by Matthew Brightbill on 3/28/15.
//  Copyright (c) 2015 Matthew Brightbill. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var detail: String
    @NSManaged var dateEntered: NSDate

}
