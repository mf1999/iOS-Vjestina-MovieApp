import Foundation
import UIKit
import PureLayout
import Kingfisher
import MovieAppData


class MovieDetailsViewController: UIViewController{
    
    private let darkGreen = UIColor(red: 45/255, green: 125/255, blue: 53/255, alpha: 1.0)
    private let offWhite = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
    
    private var quickDetailsView: UIView! // Top one with the background image
    private var summaryAndCastView: UIView! // Bottom one with the cast and crew
    
    private var movieImageView: UIImageView!
    
    private var favouriteButton: UIButton!
    private var favouriteSymbol: UIImageView!
    
    private var movieGenresAndRuntime: UILabel!
    
    private var releaseDateAndCountry: UILabel!
    
    private var nameAndYear: UILabel!
    
    private var userScoreLabelNumber: UILabel!
    private var userScoreLabelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        
        createQuickDetailsView()
        createSummaryAndCastView()
    }
    
    private func createQuickDetailsView(){
        quickDetailsView = UIView()
        
        // Create background image
        let movieDetails = MovieUseCase().getDetails(id: 111161)
        movieImageView = UIImageView()
        movieImageView.kf.setImage(with: URL(string: movieDetails!.imageUrl))
        
        // Create FAVOURITE button
        favouriteButton = UIButton(type: .custom)
        
        favouriteSymbol = UIImageView()
        favouriteSymbol.image = UIImage(named: "StarVector")
        
        favouriteButton.addSubview(favouriteSymbol)
        
        //Create movie genres and runtime text label
        movieGenresAndRuntime = UILabel()
        movieGenresAndRuntime.attributedText = getCategoriesAndRuntime(for: movieDetails!)
        
        //Create release date and country label
        releaseDateAndCountry = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movieDetails!.releaseDate)
        dateFormatter.dateFormat = "MM/dd/yyy"
        releaseDateAndCountry.text = dateFormatter.string(from: date!) + " (US)"
        
        // Create name and year label
        nameAndYear = UILabel()
        nameAndYear.attributedText = self.getNameAndYear(for: movieDetails!)
        
        // Create movie score and label
        userScoreLabelNumber = UILabel()
        userScoreLabelText = UILabel()
        
        userScoreLabelNumber.text = String(movieDetails!.rating)
        userScoreLabelText.text = "User score"
        
        quickDetailsView.addSubview(movieImageView)
        quickDetailsView.addSubview(favouriteButton)
        quickDetailsView.addSubview(movieGenresAndRuntime)
        quickDetailsView.addSubview(releaseDateAndCountry)
        quickDetailsView.addSubview(nameAndYear)
        quickDetailsView.addSubview(userScoreLabelNumber)
        quickDetailsView.addSubview(userScoreLabelText)

        view.addSubview(quickDetailsView)
    }
    
    private func createSummaryAndCastView(){
        summaryAndCastView = UIView()
        summaryAndCastView.backgroundColor = .white
        
        view.addSubview(summaryAndCastView)
    }
    
    private func styleViews(){
        
        movieImageView.autoSetDimension(.height, toSize: 327.0)
        movieImageView.contentMode = .scaleAspectFill
        self.quickDetailsView.sendSubviewToBack(movieImageView)
        
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        favouriteButton.clipsToBounds = true
        favouriteButton.backgroundColor = .darkGray
        favouriteButton.layer.cornerRadius = 0.5 * favouriteButton.bounds.size.width
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        
        favouriteSymbol.autoSetDimension(.width, toSize: 14)
        favouriteSymbol.autoSetDimension(.height, toSize: 13)
        
        movieGenresAndRuntime.textColor = .white
        movieGenresAndRuntime.textAlignment = .left
        
        releaseDateAndCountry.textColor = .white
        releaseDateAndCountry.textAlignment = .left
        
        nameAndYear.textColor = .white
        nameAndYear.textAlignment = .left
        nameAndYear.lineBreakMode = .byWordWrapping
        nameAndYear.numberOfLines = 0
        
        userScoreLabelNumber.font = .systemFont(ofSize: 16, weight: .bold)
        userScoreLabelNumber.textColor = .white
        
        userScoreLabelText.font = .systemFont(ofSize: 16, weight: .semibold)
        userScoreLabelText.textColor = .white

        
    }
    
    private func defineLayoutForViews(){
        quickDetailsView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        summaryAndCastView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        summaryAndCastView.autoPinEdge(.top, to: .bottom, of: quickDetailsView, withOffset: 0)
        
        movieImageView.autoPinEdgesToSuperviewEdges()
        
        favouriteSymbol.autoCenterInSuperview()
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        favouriteButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        
        movieGenresAndRuntime.autoPinEdge(.bottom, to: .top, of: favouriteButton, withOffset: -16)
        movieGenresAndRuntime.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        releaseDateAndCountry.autoPinEdge(.bottom, to: .top, of: movieGenresAndRuntime, withOffset: 0)
        releaseDateAndCountry.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        nameAndYear.autoPinEdge(.bottom, to: .top, of: releaseDateAndCountry, withOffset: -16)
        nameAndYear.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        nameAndYear.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        userScoreLabelNumber.autoPinEdge(.bottom, to: .top, of: nameAndYear, withOffset: -16)
        userScoreLabelNumber.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        userScoreLabelText.autoAlignAxis(.horizontal, toSameAxisOf: userScoreLabelNumber)
        userScoreLabelText.autoPinEdge(.leading, to: .trailing, of: userScoreLabelNumber, withOffset: 8)
    }
    
    @objc
    private func favouriteButtonTapped(){
        if favouriteButton.backgroundColor == .darkGray {
            favouriteButton.backgroundColor = self.darkGreen
        } else if favouriteButton.backgroundColor == self.darkGreen{
            favouriteButton.backgroundColor = .darkGray
        }
    }
    
    private func getCategoriesAndRuntime(for details: MovieDetailsModel) -> NSMutableAttributedString {
        let categories = details.categories
        var categoriesText: String = ""
        for c in categories{
            categoriesText += String(describing:  c.self).capitalized + ", "
        }
        categoriesText = String(categoriesText.dropLast(2)) + " "
        
        let runtimeText = String(format: "%dh %dmin", details.duration / 60, details.duration % 60)
        
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let normalString = NSMutableAttributedString(string:categoriesText, attributes: normalAttrs)
        
        let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:runtimeText, attributes:boldAttrs)
        
        normalString.append(attributedString)
        return normalString
        
    }
    
    private func getNameAndYear(for details: MovieDetailsModel) -> NSMutableAttributedString {
        let name = details.name
        let year = " (" + String(details.year) + ")"
        
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
        let normalString = NSMutableAttributedString(string:year, attributes: normalAttrs)
        
        let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]
        let attributedString = NSMutableAttributedString(string:name, attributes:boldAttrs)
        
        attributedString.append(normalString)
        return attributedString
    }
    
}
