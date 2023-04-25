import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class MovieDetailsViewController: UIViewController {
    private var movieDetails: MovieDetailsModel!
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
        movieDetails = MovieUseCase().getDetails(id: 111161)
        buildViews()
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        createQuickDetailsView(for: movieDetails!)
        createSummaryAndCastView(for: movieDetails!)
    }
    
    private func createQuickDetailsView(for movieDetails: MovieDetailsModel){
        quickDetailsView = UIView()
        contentView.addSubview(quickDetailsView)

        movieImageView = UIImageView()
        quickDetailsView.addSubview(movieImageView)

        favouriteButton = UIButton(type: .custom)
        quickDetailsView.addSubview(favouriteButton)

        favouriteSymbol = UIImageView()
        favouriteButton.addSubview(favouriteSymbol)
        
        movieGenresAndRuntime = UILabel()
        quickDetailsView.addSubview(movieGenresAndRuntime)

        //Create release date and country label
        releaseDateAndCountry = UILabel()
        quickDetailsView.addSubview(releaseDateAndCountry)

        // Create name and year label
        nameAndYear = UILabel()
        quickDetailsView.addSubview(nameAndYear)

        // Create movie score and label
        userScoreLabelNumber = UILabel()
        quickDetailsView.addSubview(userScoreLabelNumber)

        userScoreLabelText = UILabel()
        quickDetailsView.addSubview(userScoreLabelText)
    }
    
    private func createSummaryAndCastView(for movieDetails: MovieDetailsModel){
        summaryAndCastView = UIView()
        contentView.addSubview(summaryAndCastView)

        overviewLabel = UILabel()
        summaryAndCastView.addSubview(overviewLabel)

        summaryLabel = UILabel()
        summaryAndCastView.addSubview(summaryLabel)
        
        crewStackView = UIStackView()
        summaryAndCastView.addSubview(crewStackView)

    }
    
    private func styleViews(){
        scrollView.bounces = true
        styleQuickDetailsView()
        styleSummaryAndCastView()
    }
    
    private func styleQuickDetailsView(){
        movieImageView.kf.setImage(with: URL(string: movieDetails.imageUrl))
        movieImageView.contentMode = .scaleAspectFill
        self.quickDetailsView.sendSubviewToBack(movieImageView)
        
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        favouriteButton.clipsToBounds = true
        favouriteButton.backgroundColor = .darkGray
        favouriteButton.layer.cornerRadius = 0.5 * favouriteButton.bounds.size.width
//        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        
        favouriteSymbol.image = UIImage(named: "StarVector")
        favouriteSymbol.autoSetDimension(.width, toSize: 14)
        favouriteSymbol.autoSetDimension(.height, toSize: 13)
        
        movieGenresAndRuntime.attributedText = getCategoriesAndRuntime(for: movieDetails)
        movieGenresAndRuntime.textColor = .white
        movieGenresAndRuntime.textAlignment = .left
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movieDetails.releaseDate)
        dateFormatter.dateFormat = "MM/dd/yyy"
        releaseDateAndCountry.text = dateFormatter.string(from: date!) + " (US)"
        releaseDateAndCountry.textColor = .white
        releaseDateAndCountry.textAlignment = .left
        
        nameAndYear.attributedText = self.getNameAndYear(for: movieDetails)
        nameAndYear.textColor = .white
        nameAndYear.textAlignment = .left
        nameAndYear.lineBreakMode = .byWordWrapping
        nameAndYear.numberOfLines = 0
        
        userScoreLabelNumber.text = String(movieDetails.rating)
        userScoreLabelNumber.font = .systemFont(ofSize: 16, weight: .bold)
        userScoreLabelNumber.textColor = .white
        
        userScoreLabelText.text = "User score"
        userScoreLabelText.font = .systemFont(ofSize: 16, weight: .semibold)
        userScoreLabelText.textColor = .white
    }
    
    private func styleSummaryAndCastView(){
        summaryAndCastView.backgroundColor = .white
        
        overviewLabel.text = "Overview"
        overviewLabel.textColor = UIColor.darkBlue
        overviewLabel.font = .systemFont(ofSize: 20, weight: .bold)

        summaryLabel.text = movieDetails.summary
        summaryLabel.textColor = .black
        summaryLabel.textAlignment = .left
        summaryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.numberOfLines = 0
        
        fillStackView(with: movieDetails.crewMembers)
        crewStackView.axis = .vertical
        crewStackView.alignment = .fill
        crewStackView.distribution = .fill
        crewStackView.spacing = 24
    }
    
    private func defineLayoutForViews(){
        // scroll view
        scrollView.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        contentView.autoSetDimension(.height, toSize: view.bounds.height)
        
        quickDetailsView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        summaryAndCastView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        summaryAndCastView.autoPinEdge(.top, to: .bottom, of: quickDetailsView, withOffset: 0)
        
        movieImageView.autoSetDimension(.height, toSize: 327.0)
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
    }
    
//    @objc
//    private func favouriteButtonTapped(){
//        if favouriteButton.backgroundColor == .darkGray {
//            favouriteButton.backgroundColor = UIColor.darkGreen
//        } else if favouriteButton.backgroundColor == UIColor.darkGreen {
//            favouriteButton.backgroundColor = .darkGray
//        }
//    }
    
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
