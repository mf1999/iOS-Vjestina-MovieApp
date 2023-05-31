import Foundation

class MovieDetailsVM: ObservableObject{
    
    @Published var movieDetails: MovieDetailsStruct!
    
    public func loadDetails(movieID: Int) async {
        let urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(movieID)/details"
        let url = URL(string: urlString)!
        let request = NSMutableURLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        Task{
            let (data, response) = try! await URLSession.shared.data(for: request as URLRequest)
            movieDetails = try! JSONDecoder().decode(MovieDetailsStruct.self, from: data)
        }
    }
}
