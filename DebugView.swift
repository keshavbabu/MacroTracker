import Foundation
import SwiftUI
struct DebugView: View {
    @EnvironmentObject var log: Log
    @State var date: Date
    var body: some View {
        Form{
            Section("days Preview"){
                List(log.days){ day in
                    Text(day.date.formatted(date: .complete, time: .omitted))
                }
            }
            Section("Add Day"){
                DatePicker(
                    "Day: ",
                    selection: $date,
                    displayedComponents: [.date]
                )
            }
            Button("Save") {
                if(!(date.formatted(date: .complete, time: .omitted)==Date.now.formatted(date: .complete, time: .omitted))){
                    let day = Day(date: date)
                    log.addDayDebug(day: day)
                }
            }
        }    
        
    }
}
