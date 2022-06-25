import SwiftUI

struct Day: Codable, Identifiable, Equatable{
    let id = UUID()
    let date: Date
    var food = [Food]()
}
