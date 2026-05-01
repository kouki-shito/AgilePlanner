//
//  BacklogReducer.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/24.
//

import ComposableArchitecture
import Foundation
import SwiftUI
import SQLiteData

@Reducer
struct BacklogReducer {
    @ObservableState
    struct State: Equatable {
        @Presents var addTaskSheetState: BacklogAddSheetReducer.State?
        @FetchAll var backlogs: [Backlog]
        var isShowAddTaskSheet: Bool = false
    }
    enum Action {
        case addTaskButtonTapped
        case isDoneButtonTapped(Int)
        case listDeleteAction(IndexSet)
        case addTaskSheetAction(PresentationAction<BacklogAddSheetReducer.Action>)
    }
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .addTaskButtonTapped:
                state.addTaskSheetState = BacklogAddSheetReducer.State()
                return .none
            case .isDoneButtonTapped(_):
                state.isShowAddTaskSheet = true
                return .none
            case .listDeleteAction(_):
                //TODO
                return .none
            case .addTaskSheetAction:
                return .none
            }
        }
        .ifLet(\.$addTaskSheetState, action: \.addTaskSheetAction) {
            BacklogAddSheetReducer()
        }
    }
}
