//
//  ProfileRow.swift
//  SOSFrance
//
//  Created by andrew austin on 10/9/25.
//

import SwiftUI

struct ProfileRow: View {
    let title: String
    @Binding var value: String
    @Binding var isEditing: Bool
    var isMultiline: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Label following HIG typography
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            if isEditing {
                if isMultiline {
                    TextEditor(text: $value)
                        .font(.body)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.tertiarySystemGroupedBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.separator), lineWidth: 0.5)
                        )
                        .frame(minHeight: 80)
                        .accessibilityLabel(title)
                } else {
                    TextField("Enter \(title.lowercased())", text: $value)
                        .font(.body)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.tertiarySystemGroupedBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.separator), lineWidth: 0.5)
                        )
                        .keyboardType(keyboardType)
                        .accessibilityLabel(title)
                }
            } else {
                Text(value.isEmpty ? "Tap Edit to add" : value)
                    .font(.body)
                    .foregroundColor(value.isEmpty ? .secondary : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)
                    .accessibilityLabel("\(title): \(value.isEmpty ? "Tap Edit to add" : value)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

struct BloodTypePickerRow: View {
    let title: String
    @Binding var value: String
    @Binding var isEditing: Bool
    
    private let options: [String] = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            if isEditing {
                Picker("Blood Type", selection: $value) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .accessibilityLabel("Blood type selection")
            } else {
                Text(value.isEmpty ? "Tap Edit to add" : value)
                    .font(.body)
                    .foregroundColor(value.isEmpty ? .secondary : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)
                    .accessibilityLabel("\(title): \(value.isEmpty ? "Tap Edit to add" : value)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}


#Preview {
    @Previewable @State var value = "Sample text"
    @Previewable @State var isEditing = true
    return List {
        ProfileRow(title: "About Me", value: $value, isEditing: $isEditing)
        ProfileRow(title: "Hobbies", value: $value, isEditing: $isEditing)
        ProfileRow(title: "Skills", value: $value, isEditing: $isEditing)
        ProfileRow(title: "Location", value: $value, isEditing: $isEditing)
        ProfileRow(title: "Bio", value: $value, isEditing: $isEditing)
    }
}
