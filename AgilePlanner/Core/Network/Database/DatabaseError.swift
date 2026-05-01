//
//  DatabaseError.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

enum DatabaseError: Error {
    enum InsertError: Error {
        case titleIsEmpty
    }
    enum UpdateError: Error {
        case titleIsEmpty
    }
    enum DeleteError: Error {
        case titleIsEmpty
    }
}
