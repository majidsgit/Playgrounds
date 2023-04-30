import SwiftUI

struct SchemeTagModel: Codable, Hashable {
    let id: String
    let name: String
}

struct SchemeModel: Codable, Hashable {
    let timestamp: Int
    let colors: [String]
    let id: String
    let tags: [SchemeTagModel]
}

struct ColorSchemeModel: Codable {
    let schemes: [SchemeModel]
}
