//
//  Task.swift
//  NightPorter
//
//  Created by Jephthah Afolayan on 30/09/2020.
//

import Foundation

enum TaskType {
    case daily, weekly, monthly
}

struct Task{
    var name: String
    var type: TaskType
    var completed: Bool
    var lastCompleted: NSData?
}
