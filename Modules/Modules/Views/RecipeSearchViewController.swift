import Coordinators_Api
import UIKit
import ViewModels_Api

public class RecipeSearchViewController: UIViewController {
    private let coordinator: AppCoordinator?
    private let viewModel: RecipeViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.placeholder = Constants.searchFieldPlaceHolder
        searchController.searchBar.showsScopeBar = true
        return searchController
    }()
    
    private lazy var savedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.savedButtonTitle, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    public init(viewModel: RecipeViewModelProtocol, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = Constants.viewTitle
        
        setupSearchController()
        setupSavedButton()
        setupTableView()
    }
    
    @objc private func savedButtonTapped() {
        viewModel.onSavedButtonTapped()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupSavedButton() {
        view.addSubview(savedButton)
        
        NSLayoutConstraint.activate([
            savedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            savedButton.heightAnchor.constraint(equalToConstant: Constants.savedButtonHeight)
        ])
        
        savedButton.addTarget(self, action: #selector(savedButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: savedButton.bottomAnchor)
        ])
    }
}

// MARK: - Constants Extension

extension RecipeSearchViewController {
    private enum Constants {
        static let searchFieldPlaceHolder = "Search Recipes"
        static let cellIdentifier: String = "cell"
        static let viewTitle: String = "Recipe Search"
        static let savedButtonTitle: String = "Click to see all saved recipes"
        static let savedButtonHeight: CGFloat = 40
    }
}

// MARK: - RecipeListDelegate

extension RecipeSearchViewController: RecipeListDelegate {
    public func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Delegate

extension RecipeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        configureCell(cell, at: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.recipes[indexPath.item]
        coordinator?.showDetails(for: recipe)
    }
    
    private func configureCell(_ cell: RecipeTableViewCell, at indexPath: IndexPath) {
        let recipe = viewModel.recipes[indexPath.item]
        
        guard
            let recipeData = recipe.image,
            let recipeLabel = recipe.recipe.label
        else {
            return
        }
        
        cell.configure(
            imageData: recipeData,
            label: recipeLabel,
            isSaved: viewModel.isRecipeSaved(recipe),
            delegate: viewModel,
            indexPath: indexPath
        )
    }
}

// MARK: - Search Controller Delegate

extension RecipeSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    public func updateSearchResults(for searchController: UISearchController) { }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBarText = searchController.searchBar.text ?? ""
        viewModel.fetchRecipe(name: searchBarText)
    }
}
