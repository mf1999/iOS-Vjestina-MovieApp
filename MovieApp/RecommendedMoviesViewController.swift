import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class RecommendedMoviesViewController: UIViewController {
    
    private var categoriesCollectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    
    private let identifier = "HorizontalCell"
    
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
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.addSubview(categoriesCollectionView)
    }
    
    private func styleViews(){
        view.backgroundColor = .white
        
        categoriesCollectionView.backgroundColor = .white
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    private func defineLayoutForViews(){
        categoriesCollectionView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
}

extension RecommendedMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

extension RecommendedMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CategoryCell else {
            fatalError("FAILED DEQUEING HORIZONTAL CELL")
        }
        
        if indexPath[1] == 0 {
            cell.configure(with: MovieUseCase().popularMovies, from: "What's popular")
        } else if indexPath[1] == 1 {
            cell.configure(with: MovieUseCase().freeToWatchMovies, from: "Free to Watch")
        } else {
            cell.configure(with: MovieUseCase().trendingMovies, from: "Trending")
        }

        return cell
    }
}

extension RecommendedMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 179+16+28+40)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.layout.invalidateLayout()
    }
}
