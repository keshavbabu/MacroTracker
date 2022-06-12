import Foundation
import SwiftUI
struct SummaryView: View {
    @EnvironmentObject var log: Log
    var calories = 0
    var protein = 0
    var carbohydrates = 0
    var fat = 0
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack(alignment: .center){
                    ZStack{
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height), alignment: .leading).cornerRadius(5.0)
                        Text("Carbs").foregroundColor(Color.white)
                    }.onAppear{
                        
                    }.foregroundColor(Color.gray.opacity(0.2))
                    ZStack{
                        Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height), alignment: .leading).cornerRadius(5.0)
                        Text("Fats").foregroundColor(Color.white)
                    }.onAppear{
                        
                    }.foregroundColor(Color.gray.opacity(0.2))
                    ZStack{
                        Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height), alignment: .leading).cornerRadius(5.0)
                        Text("Protein").foregroundColor(Color.white)
                    }.onAppear{
                        
                    }.foregroundColor(Color.gray.opacity(0.2))
                }
            }
        }
    }
}
