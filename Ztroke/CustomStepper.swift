//
//  CustomStepper.swift
//  Ztroke
//
//  Created by Zulkifli on 13/04/26.
//

import SwiftUI
struct CustomStepper: View {
    @Binding var value: Int
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                if value > 0 {
                    value -= 1
                }
            }) {
                Image(systemName: "minus")
                    .frame(width: 30, height: 30)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            Text("\(value) \(value > 1 ? "Minutes" : "Minute")")
                .font(.headline)
                .frame(minWidth: 40)
            Button(action: {
                value += 1
            }) {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    @Previewable @State var value = 0
    CustomStepper(value: $value)
}
