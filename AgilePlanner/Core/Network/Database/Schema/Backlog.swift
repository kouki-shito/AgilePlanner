//
//  Backlog.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/24.
//

import Foundation
import SQLiteData

@Table
struct Backlog: Equatable, Identifiable, Sendable, Hashable {
    let id: UUID
    let created_at: Date
    var title: String
    var description: String
    var deadline: Date?
    var isIncluedeDeadlineTime: Bool
    private(set) var isDone: Bool = false
    
    init(title: String, description: String, deadline: Date? = nil, isIncluedeDeadlineTime: Bool = false) {
        self.id = UUID()
        self.created_at = Date()
        self.title = title
        self.description = description
        self.deadline = deadline
        self.isIncluedeDeadlineTime = isIncluedeDeadlineTime
    }
    
    mutating func toggleIsDone() {
        self.isDone.toggle()
    }
}
