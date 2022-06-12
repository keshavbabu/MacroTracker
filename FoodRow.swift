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
                log.addFood(food: food)
                
            }
        }
        
        
    }
}
