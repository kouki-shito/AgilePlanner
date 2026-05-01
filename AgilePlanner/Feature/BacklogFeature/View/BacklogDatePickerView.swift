//
//  BacklogDatePickerView.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

import SwiftUI
import ComposableArchitecture

struct BacklogDatePickerSheetView: View {
    
    @Bindable var store: StoreOf<BacklogDatePickerSheetReducer>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                DatePicker("", selection: $store.selectingDate, in: Date()..., displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                List {
                    HStack {
                        Text("終日")
                        Spacer()
                        Toggle("", isOn: $store.isTimeToggleOn)
                    }
                    if !store.isTimeToggleOn {
                        DatePicker("時間", selection: $store.selectingDate, in: Date()..., displayedComponents: [.hourAndMinute])
                    }
                    HStack {
                        Text("繰り返し")
                        Spacer()
                        Toggle("", isOn: $store.isLoopToggleOn)
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                Spacer()
                HStack {
                    Spacer()
                    Button("クリア", role: .destructive) {
                        store.send(.applyDateButtonTapped(nil, false))
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        store.send(.dismissButtonTapped)
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.secondary)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        store.send(.applyDateButtonTapped(store.selectingDate, !store.isTimeToggleOn))
                    } label: {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                    .tint(.green)
                    .buttonStyle(.glassProminent)
                }
            }
            .onChange(of: store.isDismiss) { _, bool in
                if bool { dismiss() }
            }
            .navigationTitle("期限の設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        BacklogDatePickerSheetView(
            store: Store(initialState: BacklogDatePickerSheetReducer.State(selectingDate: Date(), isTimeToggleOn: false), reducer: {
                BacklogDatePickerSheetReducer()
        }))
    }
}
