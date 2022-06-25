import Foundation
import SwiftUI
struct TodayView: View {
    @EnvironmentObject var log: Log
    @State var editFood = false
    var body: some View {
        ForEach(log.days[log.currentDay].food){food in
            ZStack{
                FoodRow(food: food, tappable: false)
            }
            .swipeActions{
                Button(role: .destructive) {
                    withAnimation {
                        log.remove(food: food)
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                Button(role: .none){
                    editFood = true
                }label: {
                    Label("Edit", systemImage: "edit")
                }
            }.sheet(isPresented: $editFood){
                FoodEditor(food: food)
            }
        }
    }
}
