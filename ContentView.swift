import Foundation
import SwiftUI
struct ContentView: View {
    @EnvironmentObject var foodlist: FoodList
    @EnvironmentObject var today: Today
    @State var searchText: String
    var body: some View {
        NavigationView{
            SummaryView()
                .environmentObject(today)
                .toolbar{
                ToolbarItem{
                    NavigationLink("Search", destination: {
                        SearchView()
                            .environmentObject(foodlist)
                            .navigationTitle("Search")
                    })
                }
            }
            //TodayView()
        }
    }
}
