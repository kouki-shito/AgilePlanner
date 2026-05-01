//
//  DatabaseClient.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/24.
//

import Foundation
import Dependencies
import DependenciesMacros
import SQLiteData

@DependencyClient
struct DatabaseClient: Sendable {
    var insertBacklog: @Sendable (_ backlog: Backlog) async throws -> Void
    var updateBacklog: @Sendable (_ backlog: Backlog) async throws -> Void
    var deleteBacklog: @Sendable (_ id: UUID) async throws -> Void
}

extension DatabaseClient: DependencyKey {
    static let liveValue = Self(
        insertBacklog: { backlog in
            @Dependency(\.defaultDatabase) var database
            guard !backlog.title.isEmpty else { throw DatabaseError.InsertError.titleIsEmpty }
            try database.write { db in
                try Backlog.insert { backlog }
                    .execute(db)
            }
        },
        updateBacklog: { backlog in
            @Dependency(\.defaultDatabase) var database
            guard !backlog.title.isEmpty else { throw DatabaseError.UpdateError.titleIsEmpty }
            try database.write { db in
                try Backlog.update(backlog)
                    .execute(db)
            }
        },
        deleteBacklog: { id in
            @Dependency(\.defaultDatabase) var database
            try database.write { db in
                try Backlog.find(id)
                    .delete()
                    .execute(db)
            }
        }
    )
}

extension DatabaseClient: TestDependencyKey {
    static let previewValue = Self()
    static let testValue = Self()
}

extension DependencyValues {
  var databaseClient: DatabaseClient {
    get { self[DatabaseClient.self] }
    set { self[DatabaseClient.self] = newValue }
  }
}
