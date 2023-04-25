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
        poster.kf.setImage(with: imageURL)
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        poster = UIImageView()
        addSubview(poster)
        
        likeButton = UIView()
        addSubview(likeButton)
        
        heartImage = UIImageView(image: UIImage(named: "HeartVector.svg"))
        likeButton.addSubview(heartImage)
    }
    
    private func styleViews(){
        sendSubviewToBack(self.poster)
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 20
        poster.layer.masksToBounds = true
        
        likeButton.autoSetDimension(.width, toSize: 32)
        likeButton.autoSetDimension(.height, toSize: 32)
        likeButton.backgroundColor = UIColor.favouriteCircleColor
        likeButton.layer.cornerRadius = 16
        likeButton.layer.masksToBounds = true
        
        heartImage.autoSetDimension(.width, toSize: 18)
        heartImage.autoSetDimension(.height, toSize: 16.13)
        heartImage.backgroundColor = .clear
    }
    
    private func defineLayoutForViews(){
        poster.autoPinEdgesToSuperviewEdges()

        likeButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        likeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        
        heartImage.autoCenterInSuperview()
    }
}
