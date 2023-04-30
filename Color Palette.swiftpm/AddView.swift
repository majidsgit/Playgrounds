import SwiftUI

struct AddView: View {
    let didAdd: (String) -> Void
    @State private var color = ""
    @State private var previewColor = Color(.tertiarySystemBackground)
    @State private var isLoading = false
    var body: some View {
        HStack {
            TextField("Color hex like #F1F1F1", text: $color)
                .textFieldStyle(.plain)
            
            Button(action: {
                if isLoading == false {
                    isLoading = true
                    Network.loadRandomColor { loaded in
                        guard let loaded else {
                            isLoading = false
                            return
                        }
                        color = "#" + loaded.uppercased()
                        isLoading = false
                    }
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0, style: .circular)
                        .foregroundColor(Color(.tertiarySystemBackground))
                        .frame(width: 32, height: 32)
                    if isLoading == false {
                        Image(systemName: "shuffle")
                            .foregroundColor(Color(uiColor: .lightText))
                    } else {
                        ProgressView()
                            .controlSize(.small)
                            .tint(Color(uiColor: .lightText))
                    }
                }
            })
            .frame(width: 32, height: 32)
            
            Button(action: {
                guard color.isEmpty == false && color.count == 7 else {
                    return
                }
                didAdd(color)
                color = ""
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0, style: .circular)
                        .foregroundColor(previewColor)
                        .frame(width: 32, height: 32)
                    Image(systemName: "plus")
                        .foregroundColor(Color(uiColor: .lightText))
                }
            })
            .frame(width: 32, height: 32)
        }
        .onChange(of: color, perform: { _ in
            guard color.isEmpty == false && color.count == 7 else {
                previewColor = Color(.tertiarySystemBackground)
                return
            }
            previewColor = Color(hex: color)
        })
    }
}
