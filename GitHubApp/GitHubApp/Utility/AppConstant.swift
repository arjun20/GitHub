//
//  String.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//

struct ConstantName {
    static let token = "token"
    static let authorization = "Authorization"
    static let userTitle = "Git Users"
    static let appTitle = "GitHubApp"
    static let ok = "OK"
    static let loding = "Loading user details..."
    static let repositories = "Repositories"
    static let nonFrked = "No non-forked repositories found."
    static let repository = "Repository"
    static let close = "Close"
    static let sort = "Sort"
    static let search = "Search users"

}

struct BaseURL {
    static let url: String = "https://api.github.com/"
}

struct EndPoint {
    static let users : String = "users"
}

struct ErrorMessage {
    static let jsonFaild: String = "json data faild."
}

struct imageName {
    static let followewr = "person.2"
    static let following = "person.crop.circle.badge.checkmark"
    static let language = "chevron.left.forwardslash.chevron.right"
    static let star = "star.fill"
    static let sort = "arrow.up.arrow.down"
    static let checkmark = "checkmark"
    static let search = "magnifyingglass"
    static let next = "chevron.right"
}

struct Theme {
    static let background = "Background"
    static let shadow = "shadow"
    static let shadow1 = "shadow1"
}
