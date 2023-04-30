import SwiftUI

struct ColorView: View {
    let colorHex: String
    @State private var color: Color = .black
    var body: some View {
        HStack {
            Text(colorHex)
                .bold()
            Spacer()
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(color)
                .frame(width: 32, height: 32)
        }
        .onAppear(perform: {
            color = Color(hex: colorHex)
        })
    }
}
