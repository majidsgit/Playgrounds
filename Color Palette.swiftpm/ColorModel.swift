import SwiftUI

struct ColorTag: Codable {
    let timestamp: Int
    let id: Int
    let name: String
}

struct ColorsModel: Codable {
    let hex: String
    let timestamp: Int
    let id: Int
    let tags: [ColorTag]
}

struct ColorModel: Codable {
    let colors: [ColorsModel]
    let new_color: String
}
