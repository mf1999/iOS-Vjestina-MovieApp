import UIKit
import MovieAppData


class CategoryCell: UICollectionViewCell {
    
    var movies: [MovieModel]!
    var categoryLabel: UILabel!
        
    var postersCollectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    let identifier = "MoviePosterCell"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with movies: [MovieModel], from categoryName: String){
        self.movies = movies
        self.categoryLabel.text = categoryName
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    
    private func createViews(){
        categoryLabel = UILabel()
        self.addSubview(categoryLabel)
        
        postersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        self.addSubview(postersCollectionView)
    }
    
    
    private func styleViews(){
        self.backgroundColor = .white
        
        self.layout.scrollDirection = .horizontal
        
        self.postersCollectionView.backgroundColor = .white
        postersCollectionView.dataSource = self
        postersCollectionView.delegate = self
        postersCollectionView.layer.cornerRadius = 20
        postersCollectionView.layer.masksToBounds = true
        
        postersCollectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: self.identifier)
        
        self.categoryLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    
    private func defineLayoutForViews(){
        categoryLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        categoryLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        
        postersCollectionView.autoPinEdge(.top, to: .bottom, of: categoryLabel, withOffset: 16)
        postersCollectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        postersCollectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        postersCollectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
}


extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.postersCollectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? MoviePosterCell else {
            fatalError("FAILED DEQUEING POSTER CELL")
        }
        
        cell.configure(with: URL(string: self.movies[indexPath[1]].imageUrl)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 122, height: 179)
    }
    
}



