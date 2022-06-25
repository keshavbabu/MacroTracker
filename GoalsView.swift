import Foundation
import SwiftUI
struct GoalsView: View {
    @EnvironmentObject var log: Log
    var body: some View {
            List{
                HStack{
                    Text("Calories")
                    Spacer()
                    Text(Int(log.getGoal(of: "cal")).description)
                }
                HStack{
                    Text("Carbohydrates ")
                    Text(String(Int(log.getGoal(of: "C"))) + "g")
                    Spacer()
                    Text(Int(log.goal.carbohydratesPercent).description + "%")
                }
                HStack{
                    Text("Fats ")
                    Text(String(Int(log.getGoal(of: "F"))) + "g")
                    Spacer()
                    Text(Int(log.goal.fatsPercent).description + "%")
                }
                HStack{
                    Text("Protein ")
                    Text(String(Int(log.getGoal(of: "P"))) + "g")
                    Spacer()
                    Text(Int(log.goal.proteinPercent).description + "%")
                }
                Button("Edit"){
                    
                }
            }
    }
}
