import SwiftUI

struct ContentView: View {
    
    @State private var colors = [String]()  
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                if colors.count > 0 {
                    ForEach(colors, id: \.self) { color in
                        ColorView(colorHex: color)
                            .onTapGesture {
                                // copy to clipboard
                                UIPasteboard.general.string = color
                            }
                    }
                } else {
                    VStack {
                        Spacer()
                        HStack(spacing: 10) {
                            Image(systemName: "square.dashed")
                                .foregroundColor(Color.init(uiColor: .systemGray2))
                            Text("No Color")
                                .foregroundColor(Color.init(uiColor: .systemGray2))
                        }
                        Spacer()
                    }
                    .frame(width: 300, height: 200)
                }
            }
            AddView { newColor in
                if colors.contains(newColor) == false {
                    colors.append(newColor)
                }
            }
            .padding(.top, 30)
            
            AddSchemeView(count: 5) { tappedColor in
                if colors.contains(tappedColor) == false {
                    colors.append(tappedColor)
                }
            }
            .padding(.top, 20)
        }
        .frame(width: 300, height: 600)
    }
}
