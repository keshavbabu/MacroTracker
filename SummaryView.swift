import Foundation
import SwiftUI
struct SummaryView: View {
    @EnvironmentObject var log: Log
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack(alignment: .center){
                    ZStack{
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height), alignment: .leading).cornerRadius(5.0)
                        
                    }
                        .foregroundColor(Color.gray.opacity(0.2))
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height), alignment: .center).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height), alignment: .trailing).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                }
            }
        }
    }
}
