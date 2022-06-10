import SwiftUI

class Today : ObservableObject {
    @Published var foods = [Food]()
    @Published var calories = 0
}

