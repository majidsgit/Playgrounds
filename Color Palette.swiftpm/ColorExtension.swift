import SwiftUI

extension Color {
    
    init(hex: String) {
        self = Color.color(with: hex)
    }
    
    fileprivate static func color(with hex: String) -> Color {
        let hexString = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var hexItems = [String]()
        for char in hexString {
            hexItems.append(String(char))
        }
        let r = CGFloat(Color.hexToNumber(hex: hexItems[0] + hexItems[1])) / 255
        let g = CGFloat(Color.hexToNumber(hex: hexItems[2] + hexItems[3])) / 255
        let b = CGFloat(Color.hexToNumber(hex: hexItems[4] + hexItems[5])) / 255
        let a = 1.0
        return Color(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
    
    fileprivate static func hexToNumber(hex: String) -> Int {
        if hex.count == 2 {
            let first = hexItem(hex: String(hex.first ?? Character(""))) * 16
            let second = hexItem(hex: String(hex.last ?? Character(""))) * 1
            return first + second
        }
        return 0
    }
    
    fileprivate static func hexItem(hex: String) -> Int {
        switch hex {
        case "A":
            return 10
        case "B":
            return 11
        case "C":
            return 12
        case "D":
            return 13
        case "E":
            return 14
        case "F":
            return 15
        default:
            return Int(hex) ?? 0
        }
    }
}
