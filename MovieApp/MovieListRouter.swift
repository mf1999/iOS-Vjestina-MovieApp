import UIKit
import MovieAppData

class MovieListRouter: RouterProtocol{
    private var navigationController: UINavigationController!
    private var movieListVC: MovieListViewController!
    private var movieDetailsVC: MovieDetailsViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        fixNavBarAppearance()
        
        createViews()
        styleViews()
    }
    
    // Fixes the navigationBar background color being dependant on the scroll view
    func fixNavBarAppearance(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController.navigationBar.standardAppearance = appearance;
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
    }
    
    func createViews(){
        movieListVC = MovieListViewController()
        navigationController.pushViewController(movieListVC, animated: false)
    }
    
    func styleViews(){
        movieListVC.title = "Movie List"
    }
    
    func setStartScreen(in window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetails(movieDetails: MovieDetailsModel){
        movieDetailsVC = MovieDetailsViewController(movieDetails: movieDetails)
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}