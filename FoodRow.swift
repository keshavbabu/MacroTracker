import SwiftUI

struct FoodRow: View {
    @EnvironmentObject var log: Log
    var food : Food
    
    var body: some View {
        HStack {
            Text(food.description)
                .font(.title)
            
            Spacer()
            
            Text(food.product)
                .frame(minWidth: 125)
        }.onTapGesture {
            var day = log.getDay()
            day.food.append(food)
            log.days[0] = day
        }
        
        
    }
}
