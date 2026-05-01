//
//  TextEditorWithPlaceholder.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    let placeholder: String
    let fontSize: CGFloat
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .font(.system(size: fontSize))
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: fontSize))
                    .foregroundStyle(.secondary)
                    .padding(6)
            }
        }
    }
}

#Preview {
    TextEditorWithPlaceholder(placeholder: "aaa", fontSize: 32, text: .constant(""))
}
