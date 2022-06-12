import SwiftUI
import Foundation

@main
struct MyApp: App {
    @StateObject var foodlist = FoodList()
    @StateObject var log = Log()
    var body: some Scene {
        WindowGroup{
            ContentView(searchText: "")
                    .environmentObject(log)
                    .environmentObject(foodlist)
                    .onAppear{
                        
                    }
        }
    }
}
