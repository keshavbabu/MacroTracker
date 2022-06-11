import SwiftUI

struct Day: Codable, Identifiable{
    let id = UUID()
    let date: Date
    var food = [Food]()
}
