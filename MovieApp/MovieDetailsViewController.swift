import Foundation
import UIKit
import PureLayout
import Kingfisher
import MovieAppData


class MovieDetailsViewController: UIViewController {
        
    private let darkGreen = UIColor(red: 45/255, green: 125/255, blue: 53/255, alpha: 1.0)
    private let darkBlue = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
    
    private var quickDetailsView: UIView! // Top one with the background image
    private var summaryAndCastView: UIView! // Bottom one with the cast and crew
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var movieImageView: UIImageView!
    
    private var favouriteButton: UIButton!
    private var favouriteSymbol: UIImageView!
    
    private var movieGenresAndRuntime: UILabel!
    
    private var releaseDateAndCountry: UILabel!
    
    private var nameAndYear: UILabel!
    
    private var userScoreLabelNumber: UILabel!
    private var userScoreLabelText: UILabel!
    
    private var overviewLabel: UILabel!
    private var summaryLabel: UILabel!
    
    private var crewStackView: UIStackView!
    
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
        let movieDetails = MovieUseCase().getDetails(id: 111161)
        
        scrollView = UIScrollView()
        scrollView.bounces = true
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        createQuickDetailsView(for: movieDetails!)
        createSummaryAndCastView(for: movieDetails!)
    }
    
    private func createQuickDetailsView(for movieDetails: MovieDetailsModel){
        quickDetailsView = UIView()
        
        // Create background image
        movieImageView = UIImageView()
        movieImageView.kf.setImage(with: URL(string: movieDetails.imageUrl))
        
        // Create FAVOURITE button
        favouriteButton = UIButton(type: .custom)
        
        favouriteSymbol = UIImageView()
        favouriteSymbol.image = UIImage(named: "StarVector")
        
        favouriteButton.addSubview(favouriteSymbol)
        
        //Create movie genres and runtime text label
        movieGenresAndRuntime = UILabel()
        movieGenresAndRuntime.attributedText = getCategoriesAndRuntime(for: movieDetails)
        
        //Create release date and country label
        releaseDateAndCountry = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movieDetails.releaseDate)
        dateFormatter.dateFormat = "MM/dd/yyy"
        releaseDateAndCountry.text = dateFormatter.string(from: date!) + " (US)"
        
        // Create name and year label
        nameAndYear = UILabel()
        nameAndYear.attributedText = self.getNameAndYear(for: movieDetails)
        
        // Create movie score and label
        userScoreLabelNumber = UILabel()
        userScoreLabelText = UILabel()
        
        userScoreLabelNumber.text = String(movieDetails.rating)
        userScoreLabelText.text = "User score"
        
        quickDetailsView.addSubview(movieImageView)
        quickDetailsView.addSubview(favouriteButton)
        quickDetailsView.addSubview(movieGenresAndRuntime)
        quickDetailsView.addSubview(releaseDateAndCountry)
        quickDetailsView.addSubview(nameAndYear)
        quickDetailsView.addSubview(userScoreLabelNumber)
        quickDetailsView.addSubview(userScoreLabelText)

        contentView.addSubview(quickDetailsView)
    }
    
    private func createSummaryAndCastView(for movieDetails: MovieDetailsModel){
        summaryAndCastView = UIView()
        
        overviewLabel = UILabel()
        overviewLabel.text = "Overview"
        
        summaryLabel = UILabel()
        summaryLabel.text = movieDetails.summary
        
        // Collection view stuff
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        crewStackView = UIStackView()
        
        fillStackView(with: movieDetails.crewMembers)
        
        summaryAndCastView.addSubview(overviewLabel)
        summaryAndCastView.addSubview(summaryLabel)
        summaryAndCastView.addSubview(crewStackView)

        contentView.addSubview(summaryAndCastView)
    }
    
    private func styleViews(){
        styleQuickDetailsView()
        styleSummaryAndCastView()
        
        // scroll view
        contentView.autoMatch(.width, to: .width, of: view)
        contentView.autoSetDimension(.height, toSize: view.bounds.height)
    }
    
    private func styleQuickDetailsView(){
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
    
    private func styleSummaryAndCastView(){
        summaryAndCastView.backgroundColor = .white
        
        overviewLabel.textColor = self.darkBlue
        overviewLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        summaryLabel.textColor = .black
        summaryLabel.textAlignment = .left
        summaryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.numberOfLines = 0
        
        crewStackView.axis = .vertical
        crewStackView.alignment = .fill
        crewStackView.distribution = .fill
        crewStackView.spacing = 24
        
    }
    
    private func defineLayoutForViews(){
        
        scrollView.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdgesToSuperviewEdges()
        
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
        
        overviewLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 22)
        overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        summaryLabel.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8.38)
        summaryLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        summaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        crewStackView.autoPinEdge(.top, to: .bottom, of: summaryLabel, withOffset: 5)
        crewStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        crewStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
//        crewStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
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
        var categoriesText: String = ""
        for c in details.categories{
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
    
    private func fillStackView(with crewMembers: [MovieCrewMemberModel]){
        func getHorStack() -> UIStackView{
           let horizontalStackView = UIStackView()
           horizontalStackView.axis = .horizontal
           horizontalStackView.alignment = .fill
           horizontalStackView.distribution = .fillProportionally // names look better than .fillEqualy
           horizontalStackView.spacing = 16
           
           return horizontalStackView
       }
        
        var ctr = 0
        var horizontalStackView: UIStackView = getHorStack()
        for c in crewMembers{
            if ctr % 3 == 0 {
                crewStackView.addArrangedSubview(horizontalStackView)
                horizontalStackView = getHorStack()
            }
            let name = c.name
            let role = c.role
            
            let memberView = UIView()
            let nameLabel = UILabel()
            let roleLabel = UILabel()
            
            nameLabel.text = name
            nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
            nameLabel.adjustsFontSizeToFitWidth = true
            memberView.addSubview(nameLabel)
            
            roleLabel.text = role
            roleLabel.font = .systemFont(ofSize: 14, weight: .regular)
            roleLabel.adjustsFontSizeToFitWidth = true
            memberView.addSubview(roleLabel)
            
            nameLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
            roleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
            roleLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 0)
            
            horizontalStackView.addArrangedSubview(memberView)
            ctr += 1
        }
        horizontalStackView.distribution = .fillEqually
        while ctr % 3 != 0 {
            let filler = UIView()
            horizontalStackView.addArrangedSubview(filler)
            ctr += 1
        }
        crewStackView.addArrangedSubview(horizontalStackView)
    }

}
