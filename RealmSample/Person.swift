import Foundation
import RealmSwift

public final class Person: Object {
    
    @objc public dynamic var id: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var age: Int = 0
    @objc public dynamic var isAdmin: Bool = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

extension Person: Queryable {
    
    public enum Query: QueryType {
        case nameEqual(String)
        case nameStartWith(String)
        case nameEndWith(String)
        case overAge(Int)
        case underAge(Int)
        case ageBetween(Int, Int)
        case admin(Bool)
        case nameAndAge(String, Int)
        case nameOrAge(String, Int)
        case notNameEndWith(String)
        case all

        public var predicate: NSPredicate? {
            switch self {
            case .nameEqual(let name):
                return NSPredicate(\Person.name, equal: name)
            case .nameStartWith(let name):
                return NSPredicate(\Person.name, beginsWith: name)
            case .nameEndWith(let name):
                return NSPredicate(\Person.name, endsWith: name)
            case .overAge(let age):
                return NSPredicate(\Person.age, equalOrGreaterThan: age)
            case .underAge(let age):
                return NSPredicate(\Person.age, lessThan: age)
            case .ageBetween(let min, let max):
                return NSPredicate(\Person.age, between: min, to: max)
            case .admin(let isAdmin):
                return NSPredicate(\Person.isAdmin, equal: isAdmin)
            case .nameAndAge(let name, let age):
                return NSPredicate(\Person.name, equal: name)
                        .and(NSPredicate(\Person.age, equal: age))
            case .nameOrAge(let name, let age):
                return NSPredicate(\Person.name, equal: name)
                        .or(NSPredicate(\Person.age, equal: age))
            case .notNameEndWith(let name):
                return NSPredicate.empty
                        .not(NSPredicate(\Person.name, endsWith: name))
            case .all:
                return nil
            }
        }
        
        public var sortDescriptors: [SortDescriptor] {
            return [SortDescriptor(keyPath: \Person.name)]
        }
    }
}
