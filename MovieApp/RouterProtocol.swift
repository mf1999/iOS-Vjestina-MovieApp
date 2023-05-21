import UIKit
import MovieAppData

protocol RouterProtocol{
    func setStartScreen(in window: UIWindow?, for config: Int)
    func fixNavBarAppearance()
    func showMovieDetails(movieDetails: MovieDetailsModel)
}
