import Coordinators_Api
import DataStore_Impl
import Model
import Services_Impl
import UIKit
import ViewModels_Impl
import Views

public class AppCoordinatorImpl: AppCoordinator {
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewModel = RecipeViewModel(
            service: RecipeSearchApiService.shared,
            dataStore: RecipeDataStoreImpl()
        )
        
        let recipeSearchViewController = RecipeSearchViewController(
            viewModel: viewModel,
            coordinator: self
        )
        
        viewModel.delegate = recipeSearchViewController
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(recipeSearchViewController, animated: false)
    }
    
    public func showDetails(for recipe: RecipeModel) {
        let detailsViewModel = RecipeDetailsViewModel(
            recipe: recipe,
            dataStore: RecipeDataStoreImpl()
        )
        let detailsViewController = RecipeDetailsViewController(viewModel: detailsViewModel)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
