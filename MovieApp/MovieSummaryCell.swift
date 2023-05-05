import UIKit

class MovieSummaryCell: UITableViewCell {
    public static let identifier = "MovieSummaryCell"
        
    private var moviePoster: UIImageView!
    private var movieName: UILabel!
    private var movieSummary: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createViews()
        self.styleViews()
        self.defineLayoutForViews()
    }
    
    // Get padding between cells in same section
    override func layoutSubviews() {
          super.layoutSubviews()
          contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    public func configure(image imageURL: URL, name movieName: String, year relaseYear: Int, summary movieSummary: String){
        moviePoster.kf.setImage(with: imageURL)
        
        self.movieName.text = movieName + " (" + String(relaseYear) + ")"
        
        self.movieSummary.text = movieSummary
    }
    
    private func createViews(){
        moviePoster = UIImageView()
        contentView.addSubview(moviePoster)
        
        movieName = UILabel()
        contentView.addSubview(movieName)

        movieSummary = UILabel()
        contentView.addSubview(movieSummary)
    }
    
    private func styleViews(){
        contentView.backgroundColor = .white
        
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        moviePoster.contentMode = .scaleAspectFill
        moviePoster.autoSetDimension(.height, toSize: 147)
        moviePoster.autoSetDimension(.width, toSize: 97)
        
        movieName.textAlignment = .left
        movieName.numberOfLines = 0
        movieName.lineBreakMode = .byWordWrapping
        movieName.font = .systemFont(ofSize: 16, weight: .bold)
        
        movieSummary.textAlignment = .left
        movieSummary.numberOfLines = 4
        movieSummary.lineBreakMode = .byTruncatingTail
        movieSummary.textColor = .gray
        movieSummary.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func defineLayoutForViews(){
        moviePoster.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        moviePoster.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        moviePoster.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)

        movieName.autoPinEdge(.leading, to: .trailing, of: moviePoster, withOffset: 16)
        movieName.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        movieName.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)

        movieSummary.autoPinEdge(.top, to: .bottom, of: movieName, withOffset: 8)
        movieSummary.autoPinEdge(.leading, to: .trailing, of: moviePoster, withOffset: 16)
        movieSummary.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
