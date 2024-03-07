public struct Recipes: Codable {
    public let hits: [RecipesModel]?
    
    enum CodingKeys: String, CodingKey {
        case hits
    }
}

public struct RecipesModel: Codable {
    public let recipe: Recipe
}
