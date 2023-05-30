import UIKit
import PureLayout
import Kingfisher

class MovieDetailsViewController: UIViewController {
    private var movieDetails: MovieDetailsStruct!
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
    
    init(movieDetails: MovieDetailsStruct){
        super.init(nibName: nil, bundle: nil)
        self.movieDetails = movieDetails
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        animateViews()
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
    
    private func createQuickDetailsView(for movieDetails: MovieDetailsStruct){
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
    
    private func createSummaryAndCastView(for movieDetails: MovieDetailsStruct){
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
        movieImageView.kf.setImage(with: movieDetails.imageUrl)
        movieImageView.contentMode = .scaleAspectFill
        
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        favouriteButton.clipsToBounds = true
        favouriteButton.backgroundColor = .darkGray
        favouriteButton.layer.cornerRadius = 0.5 * favouriteButton.bounds.size.width
        
        favouriteSymbol.image = UIImage(named: "StarVector")
        favouriteSymbol.autoSetDimension(.width, toSize: 14)
        favouriteSymbol.autoSetDimension(.height, toSize: 13)
        
        movieGenresAndRuntime.attributedText = getCategoriesAndRuntime(for: movieDetails)
        movieGenresAndRuntime.textColor = .white
        movieGenresAndRuntime.textAlignment = .left
        movieGenresAndRuntime.backgroundColor = .blackSemiVisibleColor
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movieDetails.releaseDate)
        dateFormatter.dateFormat = "MM/dd/yyy"
        releaseDateAndCountry.text = dateFormatter.string(from: date!) + " (US)"
        releaseDateAndCountry.textColor = .white
        releaseDateAndCountry.textAlignment = .left
        releaseDateAndCountry.backgroundColor = .blackSemiVisibleColor
        
        nameAndYear.attributedText = self.getNameAndYear(for: movieDetails)
        nameAndYear.textColor = .white
        nameAndYear.textAlignment = .left
        nameAndYear.lineBreakMode = .byWordWrapping
        nameAndYear.numberOfLines = 0
        nameAndYear.backgroundColor = .blackSemiVisibleColor
        
        userScoreLabelNumber.text = String(movieDetails.rating)
        userScoreLabelNumber.font = .systemFont(ofSize: 16, weight: .bold)
        userScoreLabelNumber.textColor = .white
        userScoreLabelNumber.backgroundColor = .blackSemiVisibleColor
        
        userScoreLabelText.text = "User score"
        userScoreLabelText.font = .systemFont(ofSize: 16, weight: .semibold)
        userScoreLabelText.textColor = .white
        userScoreLabelText.backgroundColor = .blackSemiVisibleColor
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
    
    private func animateViews(){
        userScoreLabelNumber.center = CGPoint(x: -view.bounds.width, y: view.bounds.midY)
        userScoreLabelText.center = CGPoint(x: -view.bounds.width, y: view.bounds.midY)
        nameAndYear.center = CGPoint(x: -view.bounds.width, y: view.bounds.midY)
        releaseDateAndCountry.center = CGPoint(x: -view.bounds.width, y: view.bounds.midY)
        movieGenresAndRuntime.center = CGPoint(x: -view.bounds.width, y: view.bounds.midY)
        summaryLabel.center = CGPoint(x: -view.bounds.width, y: view.bounds.midY)
        crewStackView.alpha = 0.0
        
        UIView.animate(withDuration: 0.2, delay: 0.7, options: .curveEaseOut, animations: {
            self.userScoreLabelNumber.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            self.userScoreLabelText.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            self.nameAndYear.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            self.releaseDateAndCountry.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            self.movieGenresAndRuntime.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            self.summaryLabel.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.3, options: .curveEaseOut, animations: {
            self.crewStackView.alpha = 1.0
        }, completion: nil)
    }
    
    private func defineLayoutForViews(){
        scrollView.autoPinEdgesToSuperviewSafeArea()
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
//        contentView.autoMatch(.height, to: .height, of: view)
        contentView.autoSetDimension(.height, toSize: 327*2)

        quickDetailsView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        quickDetailsView.autoPinEdge(.bottom, to: .top, of: summaryAndCastView, withOffset: 0)
        summaryAndCastView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        
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
        
        crewStackView.autoPinEdge(.top, to: .bottom, of: summaryLabel, withOffset: 0)
        crewStackView.autoPinEdge(.leading, to: .leading, of: summaryAndCastView, withOffset: 20)
        crewStackView.autoPinEdge(.trailing, to: .trailing, of: summaryAndCastView, withOffset: 20)
    }
    
    private func getCategoriesAndRuntime(for details: MovieDetailsStruct) -> NSMutableAttributedString {
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
    
    private func getNameAndYear(for details: MovieDetailsStruct) -> NSMutableAttributedString {
        let name = details.name
        let year = " (" + String(details.year) + ")"
        
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
        let normalString = NSMutableAttributedString(string:year, attributes: normalAttrs)
        
        let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)]
        let attributedString = NSMutableAttributedString(string:name, attributes:boldAttrs)
        
        attributedString.append(normalString)
        return attributedString
    }
    
    private func fillStackView(with crewMembers:[Dictionary<String, String>]){
        func getHorStack() -> UIStackView{
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 16
            
            return horizontalStackView
        }
        
        var ctr = 0
        var horizontalStackView: UIStackView = getHorStack()
        for crewMember in crewMembers{
            let role = crewMember["role"]
            let name = crewMember["name"]
            if ctr % 3 == 0 {
                crewStackView.addArrangedSubview(horizontalStackView)
                horizontalStackView = getHorStack()
            }
            
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
        horizontalStackView.alignment = .fill
        crewStackView.addArrangedSubview(horizontalStackView)
    }
}
