import SwiftUI

struct Food: Identifiable, Codable{
    let id: String
    let description: String
    let category: String
    let quantity: Double
    let product: String
    let supplier: String
    let nutrient_data: [Nutrient]?
    let unit: String
    let characteristics: [String]?
    let groups: [String]
    let units: [String]
}

struct Nutrient: Identifiable, Codable{
    let id = UUID()
    let nutrient: String
    let value: Double
}
