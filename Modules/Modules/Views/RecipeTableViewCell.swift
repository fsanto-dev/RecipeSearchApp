import UIKit
import ViewModels_Api

class RecipeTableViewCell: UITableViewCell {
    private weak var delegate: RecipeTableViewCellDelegate?
    private var indexPath: IndexPath?
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .semibold)
        label.numberOfLines = Constants.maxNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var isRecipeSaved: Bool = false {
        didSet {
            setupButtonImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        setupFoodImageView()
        setupNameLabel()
    }
    
    private func setupFoodImageView() {
        addSubview(foodImageView)
        
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.foodImageViewLeadingOffset),
            foodImageView.topAnchor.constraint(equalTo: topAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            foodImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.foodImageViewWidthPercentage)
        ])
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: Constants.nameLabelLeadingOffset),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.nameLabelTrailingOffset)
        ])
    }
    
    func configure(
        imageData: Data,
        label: String,
        isSaved: Bool,
        delegate: RecipeTableViewCellDelegate,
        indexPath: IndexPath
    ) {
        foodImageView.image = UIImage(data: imageData)
        nameLabel.text = label
        setupButtonRecipe(as: isSaved)
        
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    private func setupButtonRecipe(as saved: Bool) {
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -layoutMargins.right),
            saveButton.widthAnchor.constraint(equalToConstant: Constants.saveButtonWidth),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.saveButtonHeight)
        ])
        
        isRecipeSaved = saved
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        guard let indexPath else { return }
        isRecipeSaved = !isRecipeSaved
        delegate?.onSaveButton(with: indexPath.item)
    }
    
    private func setupButtonImage() {
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

extension RecipeTableViewCell {
    private enum Constants {
        static let foodImageViewLeadingOffset: CGFloat = 10
        static let foodImageViewWidthPercentage: CGFloat = 0.4
        
        static let labelFontSize: CGFloat = 14
        static let maxNumberOfLines: Int = 4
        static let nameLabelLeadingOffset: CGFloat = 20
        static let nameLabelTrailingOffset: CGFloat = 40
        
        static let saveButtonWidth: CGFloat = 40
        static let saveButtonHeight: CGFloat = 40
        
        static let saved: String = "bookmark"
        static let unsaved: String = "bookmark.fill"
    }
}
