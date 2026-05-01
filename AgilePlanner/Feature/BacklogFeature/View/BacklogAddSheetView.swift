//
//  BacklogAddSheetView.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

import SwiftUI
import ComposableArchitecture

struct BacklogAddSheetView: View {
    @Bindable var store: StoreOf<BacklogAddSheetReducer>
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            TextField("タスク名を入力", text: $store.title)
                .font(.system(size: 20))
                .padding(8)
            TextEditorWithPlaceholder(placeholder: "説明...", fontSize: 16, text: $store.description)
                .frame(height: 48)
                .padding(.horizontal, 8)
            Spacer()
            HStack {
                ScrollView(.horizontal) {
                    Button {
                        store.send(.dateButtonTapped)
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text(store.deadline?.dateToString(format: "MM月dd日") ?? "期限")
                                .fontWeight(.semibold)
                        }	
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(store.deadline == nil ? .gray : .accentColor, lineWidth: 0.5)
                        )
                    }
                    .foregroundStyle(store.deadline == nil ? .gray : .accentColor)
                }
                Spacer()
                Button {
                    store.send(.submitTaskButtonTapped)
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 56, height: 56)
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(!store.canSubmit)
            }
        }
        .padding(16)
        .onChange(of: store.isDismiss) { _, bool in
            if bool { dismiss() }
        }
        .sheet(item: $store.scope(state: \.datePickerSheetState, action: \.datePickerSheetAction), content: { store in
            BacklogDatePickerSheetView(store: store)
                .presentationDetents([.height(8*88)])
                .presentationBackground(.white)
        })
    }
}

#Preview {
    VStack {
        Spacer()
        BacklogAddSheetView(
            store: Store(initialState: BacklogAddSheetReducer.State(), reducer: {
                BacklogAddSheetReducer()
        }))
    }
}
