//
//  BacklogView.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/22.
//

import SwiftUI

struct BacklogView: View {
    
    var dummy = [
        Backlog(id: UUID(), endDate: nil, title: "英語の課題をやる", isDone: false),
        Backlog(id: UUID(), endDate: nil, title: "英語の課題をやる", isDone: false),
        Backlog(id: UUID(), endDate: nil, title: "英語の課題をやる", isDone: false)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(dummy,id: \.id) { task in
                        HStack() {
                            VStack {
                                Button {
                                    // TODO change isDone Toggle
                                } label: {
                                    Image(systemName: task.isDone ? "checkmark.circle" : "circle")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.system(size: 16))
                                    .lineLimit(2)
                                    .fontWeight(.regular)
                                Text("2026年12月28日")
                                    .font(.system(size: 12))
                                    .lineLimit(1)
                                    .foregroundStyle(.gray)
                                    .fontWeight(.regular)
                                Spacer()
                            }
                            .padding(.leading, 8)
                            .padding(.top, 4)
                        }
                    }
                    .onDelete(perform: { index in
                        // TODO Delete Array
                    })
                    .onMove(perform: { fromIndex, toIndex in
                        // TODO Move Array
                    })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 24)
                    .padding(.vertical,8)
                }
                .listStyle(.plain)
                .buttonStyle(.plain)
                .environment(\.defaultMinListRowHeight, .leastNonzeroMagnitude)
                Button {
                    // TODO Toggle Submit View
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
            .navigationTitle("バックログ")
        }
    }
}

#Preview {
    NavigationStack {
        BacklogView()
    }
}
