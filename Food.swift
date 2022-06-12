import SwiftUI

struct Food: Identifiable, Codable, Equatable{
    let id: String
    let description: String
    let category: String
    var quantity: Double
    let product: String
    let supplier: String
    let nutrient_data: [Nutrient]?
    let unit: String
    let characteristics: [String]?
    let groups: [String]
    let units: [String]
}

struct Nutrient: Identifiable, Codable, Equatable{
    let id = UUID()
    let nutrient: String
    let value: Double
}
