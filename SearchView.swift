import Foundation
import SwiftUI
struct SearchView: View {
    @EnvironmentObject var foodlist: FoodList
    @State var searchText: String = ""
    var body: some View {
        VStack{
            TextField("Search...", text: $searchText).onSubmit{
                Task {
                    print("Searching for " + searchText)
                    foodlist.populate(query:searchText, completion: {(str) in
                        print(str)
                    })
                }
            }.padding()
            List{
                ForEach(foodlist.foods){food in
                    //Text(food.description)
                    FoodRow(food: food)
                }
            }.toolbar{
                ToolbarItem{
                    Button("Clear"){
                        foodlist.clear()
                    }
                }
            }
        }
        
        
    }
}
