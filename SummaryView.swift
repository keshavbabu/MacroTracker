import Foundation
import SwiftUI
struct SummaryView: View {
    @EnvironmentObject var log: Log
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack(spacing: 12){
                    ZStack{
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height/10), alignment: .leading).cornerRadius(5.0)
                        
                    }
                        .foregroundColor(Color.gray.opacity(0.2))
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height/10), alignment: .center).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height/10), alignment: .trailing).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                }
                List{
                    ForEach(log.days){day in
                        Section(day.date.formatted()) {
                            ForEach(day.food){food in
                                Text(food.product)
                            }
                        }
                    }
                }
            }
        }
    }
}
