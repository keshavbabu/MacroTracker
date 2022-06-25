import SwiftUI

struct FoodRow: View {
    @EnvironmentObject var log: Log
    var food : Food
    var tappable: Bool
    var body: some View {
        HStack {
            Text(food.description)
                .font(.caption)
            Spacer()
            Text(food.product)
        }.onTapGesture {
            if(tappable){
                //call fixFood here and add the resulting food after calling the Food API
                log.addFood(food: food)
            }
        }
        
        
    }
}
