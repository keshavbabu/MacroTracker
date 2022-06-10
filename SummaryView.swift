import Foundation
import SwiftUI
struct SummaryView: View {
    var body: some View {
        GeometryReader{ geo in
                HStack(spacing: 12){
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height/10), alignment: .leading).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height/10), alignment: .center).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                    Rectangle().frame(width: (geo.size.width/3.25), height: (geo.size.height/10), alignment: .trailing).cornerRadius(5.0)
                        .foregroundColor(Color.gray.opacity(0.2))
                }
            
            
        }
    }
}
