import Foundation

struct MovieDetailsStruct: Codable{
    let id: Int
    let name: String
    let year: Int
    let duration: Int
    let releaseDate: String
    let rating: Double
    let summary: String
    let imageUrl: URL
    let categories: [String]
    let crewMembers: [Dictionary<String, String>]
}
