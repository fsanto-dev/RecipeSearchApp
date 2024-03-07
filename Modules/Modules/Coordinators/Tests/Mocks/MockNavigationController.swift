import UIKit

public class MockNavigationController: UINavigationController {
    var didCallSetViewControllers = false
    var didCallPushViewController = false
    var didCallPopViewController = false
    
    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        didCallSetViewControllers = true
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didCallPushViewController = true
        super.pushViewController(viewController, animated: animated)
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        didCallPopViewController = true
        return super.popViewController(animated: animated)
    }
}
