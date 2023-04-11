import UIKit
import PureLayout
import Kingfisher
import MovieAppData


class MovieListViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private let movies = MovieUseCase().allMovies
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()

        self.tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    
    private func createViews(){
        tableView = UITableView()
        self.view.addSubview(tableView)
    }
    
    private func styleViews(){
        self.view.backgroundColor = .white
        tableView.register(MovieSummaryCell.self, forCellReuseIdentifier: MovieSummaryCell.identifier)

    }
    
    private func defineLayoutForViews(){
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 26, left: 16, bottom: 0, right: 16))
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
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
