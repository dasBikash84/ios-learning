
import Foundation

struct TodoItem : Codable {
    var name : String
    var checked : Bool = false
    var time : Date = Date()
}

struct TodoItems : Codable {
    var items:[TodoItem] = []
}

struct CoderHelper {
    static let encoder = PropertyListEncoder()
    static let decoder = PropertyListDecoder()
}

extension Encodable{
    func getEncodedData() -> Data?{
        do{
            return try CoderHelper.encoder.encode(self)
        }catch{
            print(error)
            return nil
        }
    }
}

