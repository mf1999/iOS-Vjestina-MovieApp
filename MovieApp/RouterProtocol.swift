import UIKit

protocol RouterProtocol{
    func setStartScreen(in window: UIWindow?)
    func fixNavBarAppearance()
    func showMovieDetails(movieDetails: MovieDetailsStruct)
}
