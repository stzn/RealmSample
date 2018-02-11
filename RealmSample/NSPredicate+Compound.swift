import Foundation
import RealmSwift

public extension NSPredicate {
    
    public func compound(_ predicates: [NSPredicate], type: NSCompoundPredicate.LogicalType = .and) -> NSPredicate {
        var p = predicates
        p.insert(self, at: 0)
        
        switch type {
        case .and:
            return NSCompoundPredicate(andPredicateWithSubpredicates: p)
        case .not:
            return NSCompoundPredicate(notPredicateWithSubpredicate: self.compound(p))
        case .or:
            return NSCompoundPredicate(orPredicateWithSubpredicates: p)
        }
    }
    
    public func and(_ predicate: NSPredicate) -> NSPredicate {
        return self.compound([predicate], type: .and)
    }
    
    public func or(_ predicate: NSPredicate) -> NSPredicate {
        return self.compound([predicate], type: .or)
    }
    
    public func not(_ predicate: NSPredicate) -> NSPredicate {
        return self.compound([predicate], type: .not)
    }
}

public extension NSPredicate {
    
    public static var empty: NSPredicate {
        return NSPredicate(value: true)
    }
}
