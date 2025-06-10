//
//  Enum.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 24/05/25.
//

/// Defines sorting options for repositories based on star counts.
///
/// Conforms to `CaseIterable` to provide all sorting options,
/// and `Identifiable` for use in SwiftUI's list and menu views.
enum SortType: String, CaseIterable, Identifiable {
    
    /// Sort repositories from highest star count to lowest.
    case highToLow = "⭐ High to Low"
    
    /// Sort repositories from lowest star count to highest.
    case lowToHigh = "⭐ Low to High"

    /// The unique identifier for each case, used by SwiftUI.
    var id: String { rawValue }
}
