import Foundation
import RealmSwift

public extension NSPredicate {
    
    private convenience init<T: Object, P:RealmProperty>(_ property: KeyPath<T, P>, _ operation: String, _ value: P) {
        self.init(format: "\(property._kvcKeyPathString!) \(operation) %@", argumentArray: [value._object])
    }
    
    public convenience init<T: Object, P:EquatableProperty>(_ property: KeyPath<T, P>, equal value: P) {
        self.init(property, "=", value)
    }
    
    public convenience init<T: Object, P:EquatableProperty>(_ property: KeyPath<T, P>, notEqual value: P) {
        self.init(property, "!=", value)
    }
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, equalOrGreaterThan value: P) {
        self.init(property, ">=", value)
    }
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, equalOrLessThan value: P) {
        self.init(property, "<=", value)
    }
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, greaterThan value: P) {
        self.init(property, ">", value)
    }
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, lessThan value: P) {
        self.init(property, "<", value)
    }
    
}

// 文字列検索(NSStringの場合はエスケープをする)
public extension NSPredicate {
    
    public convenience init<T: Object, P:RegexMatchableProperty>(_ property: KeyPath<T, P>, contains value: P) {
        if let v = value._object as? NSString {
            self.init(format: "\(property._kvcKeyPathString!) CONTAINS '\(v.realmEscaped)'" )
            return
        }
        self.init(format: "\(property._kvcKeyPathString!) CONTAINS '\(value._object)'" )
    }
    
    public convenience init<T: Object, P:RegexMatchableProperty>(_ property: KeyPath<T, P>, beginsWith value: P) {
        if let v = value._object as? NSString {
            self.init(format: "\(property._kvcKeyPathString!) BEGINSWITH '\(v.realmEscaped)'" )
            return
        }
        self.init(format: "\(property._kvcKeyPathString!) BEGINSWITH '\(value._object)'" )
    }
    
    public convenience init<T: Object, P:RegexMatchableProperty>(_ property: KeyPath<T, P>, endsWith value: P) {
        if let v = value._object as? NSString {
            self.init(format: "\(property._kvcKeyPathString!) ENDSWITH '\(v.realmEscaped)'" )
            return
        }
        self.init(format: "\(property._kvcKeyPathString!) ENDSWITH '\(value._object)'" )
    }
}

// 範囲検索
public extension NSPredicate {
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, in values: [P]) {
        self.init(format: "\(property._kvcKeyPathString!) IN %@", argumentArray: values.map { $0._object } )
    }
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, between min:P, to max: P ) {
        self.init(format: "\(property._kvcKeyPathString!) BETWEEN {%@, %@}", argumentArray: [min, max] )
    }
}

// 日付範囲
public extension NSPredicate {
    
    public convenience init<T: Object, P:ComparableProperty>(_ property: KeyPath<T, P>, fromDate: Date?, to: Date?) {
        
        var format = ""
        var args = [Any]()
        if let from = fromDate {
            format += "\(property._kvcKeyPathString!) >= %@"
            args.append(from)
        }
        
        if  let to = to {
            if !format.isEmpty {
                format += " AND "
            }
            format += "\(property._kvcKeyPathString!) <= %@"
            args.append(to)
        }
        if !args.isEmpty {
            self.init(format: format, argumentArray: args)
        } else {
            self.init(value: true)
        }
    }
}

// エスケープ
public extension NSString {
    
    public var realmEscaped: NSString {
        let reps = [
            "\\":"\\\\",
            "'":"\\"
        ]
        var ret = self
        for rep in reps {
            ret = self.replacingOccurrences(of: rep.0, with: rep.1) as NSString
        }
        return ret
    }
}
