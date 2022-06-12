import SwiftUI

struct FoodEditor: View{
    @EnvironmentObject var log: Log
    var food: Food
    @Environment(\.dismiss) var dismiss
    @State private var title  = ""
    @State private var description = ""
    var body: some View{
        Form{
            Section("idk"){
                TextField(
                    "Task Title",
                    text: $title
                )
                TextField(
                    "Task Description",
                    text: $description
                )
            }
            Button("Save") {
                log.replaceFood(with: food)
                dismiss()
            }
        }
    }
}
