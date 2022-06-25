import SwiftUI

struct ProgressRingView: View{
    var progress: CGFloat
    var label: String
    var colors: [Color] = [Color.darkRed, Color.lightRed]
    
    var body: some View{
        ZStack{
            Text(label)
            Circle()
                .stroke(Color.outlineRed, lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                ).rotationEffect(.degrees(-90))
        }.frame(idealWidth: 200, idealHeight: 200, alignment: .center)
    }
}

extension Color {
    public static var outlineRed: Color {
        return Color(decimalRed: 34, green: 0, blue: 3)
    }
    
    public static var darkRed: Color {
        return Color(decimalRed: 221, green: 31, blue: 59)
    }
    
    public static var lightRed: Color {
        return Color(decimalRed: 239, green: 54, blue: 128)
    }
    
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}
