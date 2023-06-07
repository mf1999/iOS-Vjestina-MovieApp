import UIKit

class Router: RouterProtocol{
    private var navigationController: UINavigationController!
    
    private var recommendedVC: RecommendedMoviesViewController!
    private var favouritesVC: FavouritesViewController!
        
    private var movieDetailsVC: MovieDetailsViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        fixNavBarAppearance()
    }
    
    // Fixes the navigationBar background color being dependant on the scroll view
    func fixNavBarAppearance(){
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = .white
        navigationController.navigationBar.standardAppearance = navAppearance;
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
    }
        
    func setStartScreen(in window: UIWindow?) {
        let tabBarController = UITabBarController()
        
        recommendedVC = RecommendedMoviesViewController(router: self)
        recommendedVC.tabBarItem = UITabBarItem(title: "Movie list", image: UIImage(named: "HomeVector"), selectedImage: UIImage(named: "HomeFilledVector"))
        
        favouritesVC = FavouritesViewController()
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "HeartVector"), selectedImage: UIImage(named: "HeartFilledVector"))
        
        tabBarController.viewControllers = [recommendedVC, favouritesVC]
        navigationController.viewControllers = [tabBarController]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetails(id: Int){
        movieDetailsVC = MovieDetailsViewController(id: id)
        movieDetailsVC.title = "Movie details"
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
