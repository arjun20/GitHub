//
//  SearchBar.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 24/05/25.
//
import SwiftUI

/// A reusable search bar view with an icon and text input.
///
/// This view binds to a text string that can be used to filter or search content.
///
/// - Note: The text field disables autocorrection to improve search input accuracy.
struct SearchBar: View {
    
    /// The bound text string representing the current search input.
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: imageName.search)
            TextField(ConstantName.search, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .autocorrectionDisabled()
        }
        .accessibilityIdentifier("GitHubUserCard")
        .padding(12)
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color(Theme.shadow), radius: 4, x: 2, y: 2)
    }
}
