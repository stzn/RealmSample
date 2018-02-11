import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setDefault()
        return true
    }
    
    private func setDefault() {
        
        let realm = try! Realm.init()
        
        let suzuki = Person()
        suzuki.id = 1
        suzuki.name = "鈴木"
        suzuki.age = 21
        suzuki.isAdmin = true

        let satou = Person()
        satou.id = 2
        satou.name = "佐藤"
        satou.age = 18
        satou.isAdmin = true

        let ito = Person()
        ito.id = 3
        ito.name = "伊藤"
        ito.age = 25
        ito.isAdmin = false

        let kato = Person()
        kato.id = 4
        kato.name = "加藤"
        kato.age = 25
        kato.isAdmin = false

        try! realm.write {
            realm.add(suzuki, update: true)
            realm.add(satou, update: true)
            realm.add(ito, update: true)
            realm.add(kato, update: true)
        }
    }
}

