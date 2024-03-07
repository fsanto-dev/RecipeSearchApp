import Coordinators_Impl
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinatorImpl(navigationController: navigationController)
        appCoordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
