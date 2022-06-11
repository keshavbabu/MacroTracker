import SwiftUI

class Log: ObservableObject{
    @Published var days = [Day]()
}

struct CodableLog: Codable{
    var days = [Day]()
}

extension Log{
    func read(){
        
    }
    func save(){
        var codelog = CodableLog()
        codelog.days = self.days
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(codelog)
        let json = String(data: jsonData, encoding: String.Encoding.utf16)
        print(json!)
    }
    func addDay(day: Day){
        days.insert(day, at: 0)
    }
    func getDay() -> Day{
        return days[0]
    }
    func setDay(day: Day){
        
    }
    func getToday(){
        
    }
}
