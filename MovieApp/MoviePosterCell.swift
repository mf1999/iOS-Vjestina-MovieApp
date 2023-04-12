import UIKit
import Kingfisher


class MoviePosterCell: UICollectionViewCell {
    
    var poster: UIImageView!
    var likeButton: UIView!
    var heartImage: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with imageURL: URL){
        self.poster.kf.setImage(with: imageURL)
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        self.poster = UIImageView()
        self.addSubview(self.poster)
        
        self.likeButton = UIView()
        self.addSubview(likeButton)
        
        self.heartImage = UIImageView(image: UIImage(named: "HeartVector.svg"))
        self.likeButton.addSubview(heartImage)
    }
    
    private func styleViews(){
        self.sendSubviewToBack(self.poster)
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 20
        poster.layer.masksToBounds = true
        
        self.likeButton.autoSetDimension(.width, toSize: 32)
        self.likeButton.autoSetDimension(.height, toSize: 32)
        self.likeButton.backgroundColor = UIColor.favouriteCircleColor()
        self.likeButton.layer.cornerRadius = 16
        self.likeButton.layer.masksToBounds = true
        
        self.heartImage.autoSetDimension(.width, toSize: 18)
        self.heartImage.autoSetDimension(.height, toSize: 16.13)
        self.heartImage.backgroundColor = .clear
    }
    
    private func defineLayoutForViews(){
        poster.autoPinEdgesToSuperviewEdges()

        self.likeButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        self.likeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        
        self.heartImage.autoCenterInSuperview()
    }
}

