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
    func fixFood(food: Food, completion:@escaping((_ str:Food?)->())){
        let url = "https://nutrition-api.esha.com/food/" + food.id
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("9b1bf119caf94e188f11db4d1baec704", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let queryResult = try decoder.decode(Food.self, from: data!)
                DispatchQueue.main.async{
                    completion(queryResult)
                    
                }
                
            } catch  {
                print(error)
                completion(nil)
            }
        }
        task.resume()
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
            var carbs = 0.0;
            for food in days[currentDay].food{
                for nutrient in food.nutrient_data!{
                    if(nutrient.nutrient == "urn:uuid:975a8d10-8650-4e0c-9a8f-7f4aaa6ae9e2"){
                        carbs += Double(nutrient.value) * Double(food.quantity)
                    }
                }
            }
            return carbs
        case "F":
            var fats = 0.0;
            for food in days[currentDay].food{
                for nutrient in food.nutrient_data!{
                    if(nutrient.nutrient == "urn:uuid:589294dc-3dcc-4b64-be06-c07e7f65c4bd"){
                        fats += Double(nutrient.value) * Double(food.quantity)
                    }
                }
            }
            return fats
        case "P":
            var protein = 0.0;
            for food in days[currentDay].food{
                for nutrient in food.nutrient_data!{
                    if(nutrient.nutrient == "urn:uuid:666ae7df-af65-4d55-8d5f-996e6cc384ca"){
                        protein += Double(nutrient.value) * Double(food.quantity)
                    }
                }
            }
            return protein
        case "cal":
            var calories = 0.0;
            for food in days[currentDay].food{
                for nutrient in food.nutrient_data!{
                    if(nutrient.nutrient == "urn:uuid:a4d01e46-5df2-4cb3-ad2c-6b438e79e5b9"){
                        calories += Double(nutrient.value) * Double(food.quantity)
                    }
                }
            }
            return calories
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
