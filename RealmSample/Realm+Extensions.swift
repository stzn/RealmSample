import Foundation
import RealmSwift

public extension SortDescriptor {
    public init<T: Object, P:RealmProperty>(keyPath: KeyPath<T, P>, ascending: Bool = true) {
        self.init(keyPath: keyPath._kvcKeyPathString!, ascending: ascending)
    }

//   RealmOptionalは@objcが付けられないため_kvcKeyPathStringがnilになる
//   public init<T: Object, P: ComparableProperty>(keyPath: KeyPath<T, RealmOptional<P>>, ascending: Bool = true) {
//        self.init(keyPath: keyPath._kvcKeyPathString!, ascending: ascending)
//   }
}
