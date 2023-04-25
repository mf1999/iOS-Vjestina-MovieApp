import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class MovieListViewController: UIViewController {
    
    private var moviesTableView: UITableView!
    private let movies = MovieUseCase().allMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        moviesTableView = UITableView()
        view.addSubview(moviesTableView)
    }
    
    private func styleViews(){
        view.backgroundColor = .white
        moviesTableView.register(MovieSummaryCell.self, forCellReuseIdentifier: MovieSummaryCell.identifier)
    }
    
    private func defineLayoutForViews(){
        moviesTableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 26, left: 16, bottom: 0, right: 16))
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSummaryCell.identifier, for: indexPath) as? MovieSummaryCell else {
            fatalError("FAILED DEQUEUING MOVIE SUMMARY CELL")
        }
        let movie = movies[indexPath.row]
        let url = URL(string: movie.imageUrl)
        cell.configure(image: url!, name: movie.name, year: MovieUseCase().getDetails(id: movie.id)!.year, summary: movie.summary)
        return cell
    }
}
