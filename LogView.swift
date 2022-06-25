import Foundation
import SwiftUI
struct LogView: View {
    @EnvironmentObject var log: Log
    var body: some View {
        List{
            ForEach(log.days){day in 
                if let index = log.days.firstIndex(of: day) {
                    Button(action:{
                        log.currentDay = index
                    }){
                        VStack{
                            Text(day.date.formatted(date: .complete, time: .omitted))
                            ForEach(day.food){food in
                                ZStack{
                                    FoodRow(food: food, tappable: false)
                                }
                            }
                        }
                    }
                
                }
            }
        }
    }
}
