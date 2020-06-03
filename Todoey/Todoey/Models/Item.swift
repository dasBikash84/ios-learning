
import Foundation
import RealmSwift

class TodoItem : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var time : Date = Date()
    var parentCategory = LinkingObjects(fromType: TodoCategory.self, property : "items")
}

class TodoCategory : Object {
    @objc dynamic var name : String = ""
    let items = List<TodoItem>()
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

