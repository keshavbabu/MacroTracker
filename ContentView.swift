import Foundation
import SwiftUI
struct ContentView: View {
    @EnvironmentObject var foodlist: FoodList
    @EnvironmentObject var log: Log
    @State var searchText: String
    var body: some View {
        NavigationView{
            SummaryView()
                .environmentObject(log)
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
            
            //TodayView()
        }.onAppear(){
            if(log.days.count == 0){
                let day = Day(date: Date())
                log.addDay(day: day)
            }
        }
    }
}
