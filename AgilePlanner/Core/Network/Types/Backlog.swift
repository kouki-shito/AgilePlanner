//
//  Backlog.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/24.
//

import Foundation

struct Backlog: Equatable, Identifiable, Sendable {
    let id: UUID
    var endDate: Date?
    var title: String
    var isDone: Bool
}
