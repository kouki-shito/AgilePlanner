//
//  Untitled.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/23.
//

import OSLog
import SQLiteData

func appDatabase() throws -> any DatabaseWriter {
    let logger = Logger(subsystem: "MyApp", category: "Database")
    @Dependency(\.context) var context
    var configuration = Configuration()
    #if DEBUG
    configuration.prepareDatabase { db in
        db.trace(options: .profile) {
            if context == .preview {
                print("\($0.expandedDescription)")
            } else {
                logger.debug("\($0.expandedDescription)")
            }
        }
    }
    #endif
    let database = try defaultDatabase(configuration: configuration)
    logger.info("open '\(database.path)'")
    var migrator = DatabaseMigrator()
    #if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
    #endif
    migrator.registerMigration("Create tables") { db in
        try #sql(
        """
        CREATE TABLE "backlogs" (
            "id" TEXT NOT NULL,
            "created_at" TEXT NOT NULL,
            "title" TEXT NOT NULL,
            "description" TEXT NOT NULL,
            "deadline" TEXT,
            "isIncluedeDeadlineTime" INTEGER NOT NULL DEFAULT 0, 
            "isDone" INTEGER NOT NULL DEFAULT 0,
            PRIMARY KEY("id")
        )STRICT
        """
        ).execute(db)
    }
    try migrator.migrate(database)
    return database
}
