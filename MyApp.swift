import SwiftUI
import Foundation

@main
struct MyApp: App {
    @StateObject var foodlist = FoodList()
    @StateObject var today = Today()
    var body: some Scene {
        WindowGroup{
            NavigationView{
                ContentView(searchText: "")
                    .environmentObject(foodlist)
                    .environmentObject(today)
                    .navigationTitle("Home")
            }
        }
    }
}
