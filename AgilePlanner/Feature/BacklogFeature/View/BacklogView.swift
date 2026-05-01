//
//  BacklogView.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/22.
//

import SwiftUI
import ComposableArchitecture
import SQLiteData

struct BacklogView: View {
    
    @Bindable var store: StoreOf<BacklogReducer>
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(store.backlogs.enumerated(), id: \.element) { index, task in
                        HStack() {
                            VStack {
                                Button {
                                    store.send(.isDoneButtonTapped(index))
                                } label: {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.system(size: 16))
                                    .lineLimit(2)
                                    .fontWeight(.regular)
                                Text(task.deadline?.dateToString(style: task.isIncluedeDeadlineTime ? .full : .noTime) ?? "")
                                    .font(.system(size: 12))
                                    .lineLimit(1)
                                    .foregroundStyle(task.deadline?.isPast(includeTime: task.isIncluedeDeadlineTime) ?? false ? .red : .gray)
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            .padding(.leading, 8)
                        }
                    }
                    .onDelete(perform: { index in
                        store.send(.listDeleteAction(index))
                    })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 24)
                    .padding(.vertical,8)
                }
                .padding(.top, 8)
                .listStyle(.plain)
                .buttonStyle(.plain)
                .environment(\.defaultMinListRowHeight, .leastNonzeroMagnitude)
                Button {
                    store.send(.addTaskButtonTapped)
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundStyle(.orange)
                            .glassEffect()
                            .frame(width: 64, height: 64)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.trailing, 24)
                .padding(.bottom, 8)
            }
            .sheet(item: $store.scope(state: \.addTaskSheetState, action: \.addTaskSheetAction), content: { store in
                BacklogAddSheetView(store: store)
                    .presentationDetents([.height(8*25)])
                    .presentationBackground(.white)
            })
            .navigationTitle("バックログ")
        }
    }
}

#Preview {
    let _ = prepareDependencies {
        let db = try! appDatabase()
        $0.defaultDatabase = db
    }
    NavigationStack {
        BacklogView(
            store: Store(initialState: BacklogReducer.State(), reducer: {
            BacklogReducer()
        }))
    }
}
