import UIKit
import MovieAppData

protocol RouterProtocol{
    func setStartScreen(in window: UIWindow?)
    func fixNavBarAppearance()
    func showMovieDetails(movieDetails: MovieDetailsModel)
}
