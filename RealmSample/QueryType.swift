import Foundation
import RealmSwift

protocol Queryable {
    associatedtype Query: QueryType = DefaultQuery
}

extension Queryable where Self: Object {
    
    static func query(q: QueryType) -> [Self] {
        
        let realm = try! Realm()
        
        var objects = realm.objects(Self.self)
        
        if let predicate = q.predicate {
            objects = objects.filter(predicate)
        }
        objects = objects.sorted(by: q.sortDescriptors)

        var items = [Self]()
        for obj in objects {
            items.append(obj)
        }
        return items
    }
}

protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [SortDescriptor] { get }
}

enum DefaultQuery: QueryType {
    
    var predicate: NSPredicate? {
        return nil
    }
    
    var sortDescriptors: [SortDescriptor] {
        return []
    }
}
