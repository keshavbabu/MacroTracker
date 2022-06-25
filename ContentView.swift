import Foundation
import SwiftUI
struct ContentView: View {
    @EnvironmentObject var foodlist: FoodList
    @EnvironmentObject var log: Log
    @State var searchText: String
    var body: some View {
        NavigationView{
            List{
            SummaryView(calories: 1000.0, protein: 0.9, carbohydrates: 0.5, fat: 0.3)
                .environmentObject(log)
                .frame(height: 150, alignment: .center)
                .toolbar{
                ToolbarItem{
                    NavigationLink("Search", destination: {
                        SearchView()
                            .environmentObject(log)
                            .environmentObject(foodlist)
                            .navigationTitle("Search")
                    })
                }
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink("Log", destination: {
                            LogView()
                                .environmentObject(log)
                                .navigationTitle("Log")
                        })
                    }
                    ToolbarItem(placement: .bottomBar){
                        NavigationLink("Goals", destination: {
                            GoalsView()
                                .environmentObject(log)
                                .navigationTitle("Goals")
                        })
                    }
                    // DEBUG MENU:
                    // REMOVE
                    ToolbarItem(placement: .bottomBar){
                        NavigationLink("Debug", destination: {
                            DebugView(date: Date.now)
                                .environmentObject(log)
                                .navigationTitle("Debug")
                        })
                    }
                    
            }
                TodayView()
                    .environmentObject(log)
            }.navigationTitle("Home")
        }
    }
}
