import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        print("Realm path: \(Realm.Configuration.defaultConfiguration.fileURL)")
        try! Realm()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }
}

