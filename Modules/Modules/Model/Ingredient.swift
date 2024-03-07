public struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure, food: String?
    let weight: Double?
    let foodCategory, foodID: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}
