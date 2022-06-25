import Foundation
import SwiftUI
struct SummaryView: View {
    @EnvironmentObject var log: Log
    var calories: Double
    var protein: Double
    var carbohydrates: Double
    var fat: Double
    var body: some View {
            VStack{
                Text(log.days[log.currentDay].date.formatted(date: .complete, time: .omitted))
                HStack(alignment: .center){
                    ProgressRingView(progress: log.getCurrent(of: "C")/log.getGoal(of: "C"), label: "carbs").padding(5)
                    ProgressRingView(progress: log.getCurrent(of: "F")/log.getGoal(of: "F"), label: "fats").padding(5)
                    ProgressRingView(progress: log.getCurrent(of: "P")/log.getGoal(of: "P"), label: "protein").padding(5)
                }
                ZStack{
                    ProgressView(value: log.getCurrent(of: "cal"), total: log.getGoal(of: "cal"))
                        .scaleEffect(x: 1, y: 5, anchor: .trailing)
                    Text("Calories " + String(Int(log.getCurrent(of: "cal"))) + "/" + String(Int(log.getGoal(of: "cal"))))
                }.padding()
            }
    }
}
