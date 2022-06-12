import SwiftUI

class Log: ObservableObject{
    @Published var days = [Day]()
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    init() {
        do {
            let savePath = paths[0].appendingPathComponent("SavedTasks")
            let data = try Data(contentsOf: savePath)
            days = try JSONDecoder().decode([Day].self, from: data)
        } catch {
            days = []
            initEmpty()
        }
    }
}

struct CodableLog: Codable{
    var days = [Day]()
}

extension Log{
    func save() {
        do {
            let savePath = paths[0].appendingPathComponent("SavedTasks")
            let data = try JSONEncoder().encode(days)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    func initEmpty(){
        if(days.count == 0){
            let day = Day(date: Date())
            addDay(day: day)
        }
    }
    func addDay(day: Day){
        days.insert(day, at: 0)
    }
    func addFood(food: Food){
        
        if(!Calendar.current.isDateInToday(days[0].date)){
            addDay(day: Day(date: Date()))
        }
        days[0].food.append(food)
        save()
    }
    func remove(food: Food){
        if let index = days[0].food.firstIndex(of: food) {
            days[0].food.remove(at: index)
        }
        save()
    }
    func replaceFood(with: Food){
        if let offset = days[0].food.firstIndex(where: {$0.id == with.id}) {
            days[0].food[offset] = with;
            print("replaced")
        } else {
            print("bruh")
        }
    }
}
