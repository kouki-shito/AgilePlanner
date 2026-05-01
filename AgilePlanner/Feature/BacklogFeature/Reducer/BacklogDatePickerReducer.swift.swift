//
//  BacklogDatePickerReducer.swift.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

import ComposableArchitecture
import Foundation
import SwiftUI
import SQLiteData

@Reducer
struct BacklogDatePickerSheetReducer {
    @ObservableState
    struct State: Equatable {
        var selectingDate: Date
        var isDismiss: Bool = false
        var isTimeToggleOn: Bool
        var isLoopToggleOn: Bool = false
    }
    enum Action: BindableAction {
        case applyDateButtonTapped(Date?, Bool)
        case dismissButtonTapped
        case binding(BindingAction<State>)
    }
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .applyDateButtonTapped:
                state.isDismiss = true
                return .none
            case .dismissButtonTapped:
                state.isDismiss = true
                return .none
            case .binding:
                return .none
            }
        }
    }
}
