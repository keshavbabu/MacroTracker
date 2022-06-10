import SwiftUI

class FoodList : ObservableObject {
    @Published var foods = [Food]()
}

struct QueryResult: Codable{
    let query: String
    let total: Int
    let items: [Food]
}

extension FoodList{
    func populate(query: String, completion:@escaping((_ str:String?)->())){
        let url = "https://nutrition-api.esha.com/foods?query="+query.lowercased().replacingOccurrences(of: " ", with: "%20").filter("abcdefghijklmnopqrstuvwxyz-%1234567890".contains)+"&start=0&count=25&spell=true"
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("9b1bf119caf94e188f11db4d1baec704", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
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
                    self.foods = queryResult.items
                }
                
            } catch  {
                print(error)
                completion(nil)
            }
        }
        task.resume()
        
    }
    func clear(){
        foods.removeAll()
    }
}
