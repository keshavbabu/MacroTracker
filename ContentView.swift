import Foundation
import SwiftUI
struct ContentView: View {
    @EnvironmentObject var foodlist: FoodList
    @EnvironmentObject var log: Log
    @State var editFood = false
    @State var searchText: String
    var body: some View {
        NavigationView{
            List{
            SummaryView()
                .environmentObject(log)
                .frame(height: 90, alignment: .center)
                .toolbar{
                ToolbarItem{
                    NavigationLink("Search", destination: {
                        SearchView()
                            .environmentObject(log)
                            .environmentObject(foodlist)
                            .navigationTitle("Search")
                    })
                }
            }
                ForEach(log.days[0].food){food in
                    ZStack{
                        FoodRow(food: food, tappable: false)
                    }
                    .swipeActions{
                        Button(role: .destructive) {
                            withAnimation {
                                log.remove(food: food)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button(role: .none){
                            editFood = true
                        }label: {
                            Label("Edit", systemImage: "edit")
                        }
                    }.sheet(isPresented: $editFood){
                        FoodEditor(food: food)
                    }
                    
                }
            }.navigationTitle("Home")
        }
        
    }
}
