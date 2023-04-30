import SwiftUI

class Network: NSObject {
    
    static func loadRandomColor(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://www.colr.org/json/color/random") else {
            print("wrong url path.")
            return completion(nil)
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data else {
                if let error { print(error.localizedDescription) }
                return completion(nil)
            }
            guard let item = try? JSONDecoder().decode(ColorModel.self, from: data) else {
                print("unable to decode data.")
                return completion(nil)
            }
            completion(item.new_color)
        }.resume()
    }
    
    static func loadRandomScheme(count: Int = 1, completion: @escaping (ColorSchemeModel?) -> Void) {
        guard let url = URL(string: "https://www.colr.org/json/schemes/random/\(count)") else {
            print("wrong url path.")
            return completion(nil)
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data else {
                if let error { print(error.localizedDescription) }
                return completion(nil)
            }
            guard let item = try? JSONDecoder().decode(ColorSchemeModel.self, from: data) else {
                print("unable to decode data.")
                return completion(nil)
            }
            completion(item)
        }.resume()
    }
}
