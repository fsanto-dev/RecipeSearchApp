import UIKit
import ViewModels_Api

public class RecipeDetailsViewController: UIViewController {
    private let viewModel: RecipeDetailsViewModelProtocol
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private var isRecipeSaved: Bool = false {
        didSet {
            updateSaveButtonImage()
        }
    }
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    public init(viewModel: RecipeDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = Constants.viewTitle
        
        setupRecipeImageView()
        setupSaveButton()
        setupScrollView()
        setupStackView()
        setupAndDisplayRecipeDetails()
    }
    
    private func setupRecipeImageView() {
        view.addSubview(recipeImageView)
        if let recipeData = viewModel.recipe.image {
            recipeImageView.image = UIImage(data: recipeData)
        }
        
        NSLayoutConstraint.activate([
            recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            recipeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.recipeImageViewPercentage)
        ])
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: recipeImageView.centerYAnchor),
            saveButton.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.layoutMargins.right),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.saveButtonHeight)
        ])
        isRecipeSaved = viewModel.isRecipeSaved(viewModel.recipe)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: Constants.scrollViewTopOffset),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.stackViewLeadingOffset),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.stackViewTrailingOffset),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupAndDisplayRecipeDetails() {
        guard let ingredients = viewModel.recipe.recipe.ingredientLines else { return }
        for ingredient in ingredients {
            let detailLabel = createLabel(withText: "- \(ingredient)")
            stackView.addArrangedSubview(detailLabel)
        }
        updateStackViewWidth()
    }
    
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = Constants.labelFont
        return label
    }
    
    private func updateStackViewWidth() {
        let contentWidth = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        stackView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        isRecipeSaved.toggle()
        viewModel.onSaveButton()
    }
    
    private func updateSaveButtonImage() {
        guard
            let bookmark = UIImage(systemName: Constants.saved)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            let bookmarkFill = UIImage(systemName: Constants.unsaved)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        else { return }
        isRecipeSaved
        ? saveButton.setImage(bookmarkFill, for: .normal)
        : saveButton.setImage(bookmark, for: .normal)
    }
}

// MARK: - Constants Extension

extension RecipeDetailsViewController {
    private enum Constants {
        static let recipeImageViewPercentage: CGFloat = 0.7
        
        static let saveButtonHeight: CGFloat = 40
        
        static let saved: String = "bookmark"
        static let unsaved: String = "bookmark.fill"
        
        static let viewTitle: String = "Recipe Ingredients"
        
        static let labelFont: UIFont = .boldSystemFont(ofSize: 15)
        
        static let scrollViewTopOffset: CGFloat = 20
        
        static let stackViewLeadingOffset: CGFloat = 20
        static let stackViewTrailingOffset: CGFloat = 20
        static let stackViewSpacing: CGFloat = 10
    }
}
