//
//  DayModel.swift
//  Stay aware
//
//  Created by Олег Стригунов on 27.04.2023.
//

import Foundation
import CoreData

struct DayModel {
    let id: NSManagedObjectID
    let day: String
    let time: String
    let note: String
    let status: String
}
