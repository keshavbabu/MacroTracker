import SwiftUI

class Log: ObservableObject{
    @Published var days = [Day]()
    @Published var currentDay = 0
    @Published var goal: Goal
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    init() {
        do {
            var savePath = paths[0].appendingPathComponent("SavedDays")
            var data = try Data(contentsOf: savePath)
            days = try JSONDecoder().decode([Day].self, from: data)
            
            savePath = paths[0].appendingPathComponent("SavedGoal")
            data = try Data(contentsOf: savePath)
            goal = try JSONDecoder().decode(Goal.self, from: data)
        } catch {
            goal = Goal(calories: 2000.0, carbohydratesPercent: 50.0, fatsPercent: 25.0, proteinPercent: 25.0)
            days = []
            initEmpty()
        }
        if(!Calendar.current.isDateInToday(days[0].date)){
            let day = Day(date: Date())
            addDay(day: day)
        }
    }
}


extension Log{
    func fixFood(food: Food, completion:@escaping((_ str:String?)->())) -> Food{
        let url = "https://nutrition-api.esha.com/food/" + food.id
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("9b1bf119caf94e188f11db4d1baec704", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            //print((try? JSONSerialization.jsonObject(with: data!)) as? [String: Any])
            if error != nil {
                print("error=\(String(describing: error))")
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let queryResult = try decoder.decode(QueryResult.self, from: data!)
                DispatchQueue.main.async{
                    completion(queryResult.query)
                }
                
            } catch  {
                print(error)
                completion(nil)
            }
        }
        task.resume()
        return food
    }
    func getGoal(of: String) -> Double{
        switch(of){
        case "C":
            return round((goal.calories * (goal.carbohydratesPercent * 0.01) / 4.0))
        case "F":
            return round((goal.calories * (goal.fatsPercent * 0.01) / 9.0))
        case "P":
            return round((goal.calories * (goal.proteinPercent * 0.01) / 4.0))
        case "cal":
            return goal.calories
        default:
            return 0.0
        }
    }
    func getCurrent(of: String) -> Double{
        switch(of){
        case "C":
            return round((goal.calories * (goal.carbohydratesPercent * 0.01) / 4.0))
        case "F":
            return round((goal.calories * (goal.fatsPercent * 0.01) / 9.0))
        case "P":
            return round((goal.calories * (goal.proteinPercent * 0.01) / 4.0))
        case "cal":
            //var calories = 0.0;
            for food in days[currentDay].food{
                
            }
            return goal.calories
        default:
          return 0.0
        }
    }
    func save() {
        do {
            var savePath = paths[0].appendingPathComponent("SavedDays")
            var data = try JSONEncoder().encode(days)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            
            savePath = paths[0].appendingPathComponent("SavedGoal")
            data = try JSONEncoder().encode(goal)
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
        save()
    }
    func addDayDebug(day: Day){
        days.append(day)
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(identifier: "UTC")!
        days = days.sorted(by: {($0.date).compare($1.date) == .orderedDescending})
        save()
    }
    func addFood(food: Food){
        if(!Calendar.current.isDateInToday(days[currentDay].date)){
            addDay(day: Day(date: Date()))
        }
        days[currentDay].food.append(food)
        save()
    }
    func remove(food: Food){
        if let index = days[currentDay].food.firstIndex(of: food) {
            days[currentDay].food.remove(at: index)
        }
        save()
    }
    func replaceFood(with: Food){
        if let offset = days[currentDay].food.firstIndex(where: {$0.id == with.id}) {
            days[currentDay].food[offset] = with;
            print("replaced")
        } else {
            print("bruh")
        }
    }
}
