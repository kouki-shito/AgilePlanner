//
//  BacklogAddSheetReducer.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

import ComposableArchitecture
import Foundation
import SwiftUI
import SQLiteData

@Reducer
struct BacklogAddSheetReducer {
    @ObservableState
    struct State: Equatable {
        @Presents var datePickerSheetState: BacklogDatePickerSheetReducer.State?
        var title: String = ""
        var description: String = ""
        var deadline: Date?
        var isIncluedeDeadlineTime: Bool = false
        var canSubmit: Bool = false
        var isDismiss: Bool = false
    }
    enum Action: BindableAction {
        case submitTaskButtonTapped
        case dateButtonTapped
        case binding(BindingAction<State>)
        case datePickerSheetAction(PresentationAction<BacklogDatePickerSheetReducer.Action>)
        case dismiss
    }
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .submitTaskButtonTapped:
                @Dependency(\.databaseClient) var db: DatabaseClient
                return .run { [title = state.title, description = state.description, deadline = state.deadline, isIncluedeDeadlineTime = state.isIncluedeDeadlineTime] send in
                    do {
                        try await db.insertBacklog(backlog: Backlog(title: title, description: description, deadline: deadline, isIncluedeDeadlineTime: isIncluedeDeadlineTime))
                    } catch(let err) {
                        print(err)
                    }
                    await send(.dismiss)
                }
            case .dateButtonTapped:
                state.datePickerSheetState = BacklogDatePickerSheetReducer.State(selectingDate: state.deadline ?? Date(), isTimeToggleOn: !state.isIncluedeDeadlineTime)
                return .none
            case .binding(\.title):
                state.canSubmit = !state.title.isEmpty
                return .none
            case .binding:
                return .none
            case .datePickerSheetAction(.presented(.applyDateButtonTapped(let date, let isTimeInclude))):
                if let date = date, !isTimeInclude {
                    state.deadline = date.deleteTime()
                } else {
                    state.deadline = date
                }
                state.isIncluedeDeadlineTime = isTimeInclude
                return .none
            case .datePickerSheetAction:
                return .none
            case .dismiss:
                state.isDismiss = true
                return .none
            }
        }
        .ifLet(\.$datePickerSheetState, action: \.datePickerSheetAction) {
            BacklogDatePickerSheetReducer()
        }
    }
}
