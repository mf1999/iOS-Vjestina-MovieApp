import UIKit
import MovieAppData

class RecommendedAndFavsRouter: RouterProtocol{
    private var navigationController: UINavigationController!
    private var tabBarController: UITabBarController!
    
    private var recommenedMoviesVC: RecommendedMoviesViewController!
    private var favouritesVC: FavouritesViewController!
    private var movieDetailsVC: MovieDetailsViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        fixNavBarAppearance()
        
        createViews()
        styleViews()
    }
    
    // Fixes the navigationBar background color being dependant on the scroll view
    func fixNavBarAppearance(){
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .white
        navigationController.navigationBar.standardAppearance = navAppearance;
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
    }
    
    func fixTabBarAppearance(){
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = .white
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
    }
    
    func createViews(){
        recommenedMoviesVC = RecommendedMoviesViewController(router: self)
        let homeImg = UIImage(named: "HomeVector")
        recommenedMoviesVC.tabBarItem = UITabBarItem(title: "Movie List", image: homeImg, selectedImage: homeImg)
        navigationController.pushViewController(recommenedMoviesVC, animated: false)
        
        favouritesVC = FavouritesViewController()
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites",
                                               image: UIImage(named: "HeartVector"),
                                               selectedImage: UIImage(named: "HeartFilledVector"))
        
        tabBarController = UITabBarController()
        fixTabBarAppearance()
        tabBarController.viewControllers = [navigationController, favouritesVC]
        
    }
    
    func styleViews(){
        recommenedMoviesVC.title = "Movie List"
    }
    
    func setStartScreen(in window: UIWindow?) {
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetails(movieDetails: MovieDetailsModel){
        movieDetailsVC = MovieDetailsViewController(movieDetails: movieDetails)
        movieDetailsVC.title = "Movie details"
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
