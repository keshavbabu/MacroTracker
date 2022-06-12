import SwiftUI

struct FoodEditor: View{
    @EnvironmentObject var log: Log
    @State var food: Food
    @Environment(\.dismiss) var dismiss
    var body: some View{
        NavigationView{
        Form{
            Section("Quantity"){
                Stepper(value: $food.quantity, in: 1...999) {
                    Text("\(Int(food.quantity))")
                }
            }
            Button("Save") {
                log.replaceFood(with: food)
                dismiss()
            }
        }.navigationTitle("FoodEditor")
        }
    }
}
