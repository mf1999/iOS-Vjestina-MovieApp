import Foundation

class RecommendedMoviesVM: ObservableObject{
    
    @Published var ftwMovies: [SingleMovieStruct] = []
    @Published var popularMovies: [SingleMovieStruct] = []
    @Published var trendingMovies: [SingleMovieStruct] = []
    
    public func loadMovies(in category: String, with criterias: [String]) async {
        for criterion in criterias {
            let urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(category)?criteria=\(criterion)"
            let url = URL(string: urlString)!
            let request = NSMutableURLRequest(url: url)
            request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
            let (data, response) = try! await URLSession.shared.data(for: request as URLRequest)
            let result = try! JSONDecoder().decode([SingleMovieStruct].self, from: data)
            
            if category == "free-to-watch" {
                ftwMovies.insert(contentsOf: result, at: 0)
            }
            else if category == "popular" {
                popularMovies.insert(contentsOf: result, at: 0)
            }
            else if category == "trending" {
                trendingMovies.insert(contentsOf: result, at: 0)
            }
        }
    }
    
    public func loadFreeToWatch() async{
        await loadMovies(in: "free-to-watch", with: ["MOVIE", "TV_SHOW"])
    }
    public func loadPopular() async {
        await loadMovies(in: "popular", with: ["FOR_RENT", "IN_THEATERS", "ON_TV", "STREAMING"])
    }
    public func loadTrending() async{
        await loadMovies(in: "trending", with: ["THIS_WEEK", "TODAY"])
    }
}
