import Foundation

public protocol RealmProperty {
    var _object: AnyObject { get }
}

public protocol EquatableProperty: RealmProperty {}
public protocol ComparableProperty: EquatableProperty {}
public protocol RegexMatchableProperty: RealmProperty {}

extension Bool: EquatableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int16: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int32: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int64: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Float: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Double: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Date: EquatableProperty {
    public var _object: AnyObject { return self as NSDate }
}
extension NSDate: EquatableProperty {
    public var _object: AnyObject { return self }
}
extension String: EquatableProperty, RegexMatchableProperty {
    public var _object: AnyObject { return self as NSString }
}
extension NSString: EquatableProperty, RegexMatchableProperty {
    public var _object: AnyObject { return self }
}
extension Data: EquatableProperty {
    public var _object: AnyObject { return self as NSData }
}
extension NSData: EquatableProperty {
    public var _object: AnyObject { return self }
}
extension URL: EquatableProperty {
    public var _object: AnyObject { return self as NSURL }
}
extension NSURL: EquatableProperty {
    public var _object: AnyObject { return self }
}
extension UUID: EquatableProperty {
    public var _object: AnyObject { return self as NSUUID }
}
extension NSUUID: EquatableProperty {
    public var _object: AnyObject { return self }
}
