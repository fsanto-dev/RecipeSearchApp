public struct Recipe: Codable, Hashable {
    public let uri: String?
    public let label: String?
    public let image: String?
    public let dietLabels, cautions, healthLabels: [String]?
    public let ingredientLines: [String]?
    public let ingredients: [Ingredient]?
    public let calories: Double?
    public let totalTime: Int?
    public let cuisineType: [String]?
    public let totalNutrients, totalDaily: [String: Total]?
    public let digest: [Digest]?
    public let tags: [String]?
    
    public init(
        uri: String? = nil,
        label: String? = nil,
        image: String? = nil,
        dietLabels: [String]? = nil,
        cautions: [String]? = nil,
        healthLabels: [String]? = nil,
        ingredientLines: [String]? = nil,
        ingredients: [Ingredient]? = nil,
        calories: Double? = nil,
        totalTime: Int? = nil,
        cuisineType: [String]? = nil,
        totalNutrients: [String: Total]? = nil,
        totalDaily: [String: Total]? = nil,
        digest: [Digest]? = nil,
        tags: [String]? = nil
    ) {
        self.uri = uri
        self.label = label
        self.image = image
        self.dietLabels = dietLabels
        self.cautions = cautions
        self.healthLabels = healthLabels
        self.ingredientLines = ingredientLines
        self.ingredients = ingredients
        self.calories = calories
        self.totalTime = totalTime
        self.cuisineType = cuisineType
        self.totalNutrients = totalNutrients
        self.totalDaily = totalDaily
        self.digest = digest
        self.tags = tags
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uri)
    }
    
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uri == rhs.uri
    }
}
