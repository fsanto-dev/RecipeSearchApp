import Foundation
import Model
import Services_Api

public struct RecipeSearchApiService: RecipeSearchService {
    public static let shared = RecipeSearchApiService()
    
    private init() { }
    
    public func searchRecipes(
        with name: String,
        completion: @escaping (Recipes?, ServiceError?) -> Void
    ) {
        guard let url = Constants.recipeURL(with: name)?.url else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(nil, .requestFailed)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Recipes.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }.resume()
    }
    
    public func fetchData(
        for url: String,
        completion: @escaping (Data?, ServiceError?) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(nil, .invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(nil, .invalidResponse)
                return
            }
            completion(data, nil)
        }.resume()
    }
}

// MARK: - Constants Extension

extension RecipeSearchApiService {
    private enum Constants {
        private static let baseURL = "https://api.edamam.com/api/recipes/v2"
        private static let appID = "c83d4f82"
        private static let appKey = "598f8c20cd2413267536deb174292414"
        private static let type = "any"
        
        static func recipeURL(with name: String) -> URLComponents? {
            var components = URLComponents(string: Constants.baseURL)
            
            components?.queryItems = [
                URLQueryItem(name: "app_id", value: Constants.appID),
                URLQueryItem(name: "app_key", value: Constants.appKey),
                URLQueryItem(name: "type", value: Constants.type),
                URLQueryItem(name: "q", value: name)
            ]
            
            return components
        }
    }
}
