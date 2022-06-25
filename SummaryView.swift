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
                    ProgressRingView(progress: 0.75, label: "carbs").padding(5)
                    ProgressRingView(progress: 0.5, label: "fats").padding(5)
                    ProgressRingView(progress: 0.85, label: "protein").padding(5)
                }
                ZStack{
                    ProgressView(value: log.getCurrent(of: "cal"), total: log.getGoal(of: "cal"))
                        .scaleEffect(x: 1, y: 5, anchor: .trailing)
                    Text("Calories")
                }.padding()
            }
    }
}
