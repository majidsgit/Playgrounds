import SwiftUI

struct AddSchemeItemView: View {
    let color: String
    let onTap: () -> Void
    var body: some View {
        RoundedRectangle(cornerRadius: 8.0, style: .circular)
            .frame(width: 32, height: 32)
            .foregroundColor(Color(hex: color))
            .onTapGesture(perform: onTap)
    }
}

struct AddSchemeView: View {
    let count: Int
    let didAdd: (String) -> Void
    @State private var previewColor = Color(.tertiarySystemBackground)
    @State private var isLoading = false
    @State private var scheme: ColorSchemeModel? = nil
    var body: some View {
        VStack {
            HStack {
                TextField("Load random schemes", text: .constant(""))
                    .disabled(true)
                Spacer()
                Button(action: {
                    if isLoading == false {
                        isLoading = true
                        Network.loadRandomScheme(count: count) { scheme in
                            guard let scheme else {
                                isLoading = false
                                return
                            }
                            self.scheme = scheme
                            isLoading = false
                        }
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8.0, style: .circular)
                            .foregroundColor(Color(.tertiarySystemBackground))
                            .frame(width: 32, height: 32)
                        if isLoading == false {
                            Image(systemName: "swatchpalette")
                                .foregroundColor(Color(uiColor: .lightText))
                        } else {
                            ProgressView()
                                .controlSize(.small)
                                .tint(Color(uiColor: .lightText))
                        }
                    }
                })
                .frame(width: 32, height: 32)
            }
            
            if let scheme {
                ForEach(scheme.schemes, id: \.self) { schemeItem in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(schemeItem.colors, id:\.self) { color in
                                AddSchemeItemView(color: color) {
                                    didAdd("#" + color.uppercased())
                                }
                            }
                        }
                    }
                }
                .padding(.top, 20)
            } else {
                HStack(spacing: 10) {
                    Image(systemName: "square.dashed")
                        .foregroundColor(Color.init(uiColor: .systemGray2))
                    Text("No Scheme")
                        .foregroundColor(Color.init(uiColor: .systemGray2))
                }
                .padding(.top, 20)
            }
            
        }
    }
}

