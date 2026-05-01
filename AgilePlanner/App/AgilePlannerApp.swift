//
//  AgilePlannerApp.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/22.
//

import SwiftUI
import SQLiteData

@main
struct AgilePlannerApp: App {
    
    init() {
        prepareDependencies {
            let db = try! appDatabase()
            $0.defaultDatabase = db
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ParentTabView()
        }
    }
}
