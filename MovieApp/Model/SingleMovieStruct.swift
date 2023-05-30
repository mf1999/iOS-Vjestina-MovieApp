import Foundation

struct SingleMovieStruct: Codable{
    let id: Int
    let name: String
    let year: Int
    let summary: String
    let imageUrl: URL
}
