//
//  ParentView.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/23.
//

import SwiftUI
import ComposableArchitecture

struct ParentTabView: View {
    var body: some View {
        TabView {
            Tab("タスク", systemImage: "tray.fill") {
                BacklogView(
                    store: Store(initialState: BacklogReducer.State(), reducer: {
                    BacklogReducer()
                }))
            }
        }
    }
}

#Preview {
    ParentTabView()
}
