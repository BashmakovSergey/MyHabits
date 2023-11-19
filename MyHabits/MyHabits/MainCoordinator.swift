import UIKit

protocol Coordinator {}

final class MainCoordinator: Coordinator {
    
    private var mainTabBarController: UITabBarController
    
    init() {
        mainTabBarController = UITabBarController()
    }
    
    func start() -> UIViewController {
        setTabBarController()
        return mainTabBarController
    }
    
    private func setTabBarController(){
        mainTabBarController.tabBar.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        mainTabBarController.view.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        UITabBar.appearance().tintColor = .MyHabitsColor.purpleColor
        addControllersToTabBar()
    }
    
    private func addControllersToTabBar(){
        mainTabBarController.viewControllers = [crateHabits(), createInfo()]
    }
    
    private func crateHabits() -> UINavigationController {
        let habitsViewController = HabitsViewController()
        let habitsNavigationController = UINavigationController(rootViewController: habitsViewController)
        habitsNavigationController.title = "Привычки"
        habitsNavigationController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName:"rectangle.grid.1x2"), tag: 0)
        return habitsNavigationController
    }

    private func createInfo() -> UINavigationController {
        let infoViewController = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        infoNavigationController.title = "Информация"
        infoNavigationController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle"), tag: 1)
        return infoNavigationController
    }
    
}
