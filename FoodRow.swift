import SwiftUI

struct FoodRow: View {
    var food : Food
    
    var body: some View {
        HStack {
            Text(food.description)
                .font(.title)
            
            Spacer()
            
            Text(food.product)
                .frame(minWidth: 125)
        }
        
        
    }
}
