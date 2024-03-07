import Foundation

public struct RecipeModel: Codable, Hashable {
    public let recipe: Recipe
    public let image: Data?
    
    public init(recipe: Recipe, image: Data?) {
        self.recipe = recipe
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case recipe
        case image
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(recipe.uri)
    }
    
    public static func == (lhs: RecipeModel, rhs: RecipeModel) -> Bool {
        return lhs.recipe.uri == rhs.recipe.uri
    }
}
