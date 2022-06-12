import Foundation
import SwiftUI
struct SearchView: View {
    @EnvironmentObject var foodlist: FoodList
    @EnvironmentObject var log: Log
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
                    FoodRow(food: food, tappable: true).environmentObject(log)
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
