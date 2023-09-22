//
//  MealCell.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import UIKit

final class MealCell: UITableViewCell {
    let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        mealImageView.image = nil
    }
    
    func setup(_ meal: Meal) {
        titleLabel.text = meal.strMeal
        configImage(with: meal.strMealThumb)
    }
    
    func configImage(with textURL: String) {
        guard let url = URL(string: "\(textURL)/preview") else { return }
        Task.detached {
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            await self.updateImage(with: image)
        }
    }
    
    @MainActor
    func updateImage(with image: UIImage?) async {
        mealImageView.image = image
    }
    
    private func setupUI() {
        contentView.addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0)
        ])
        
        horizontalStack.addArrangedSubview(mealImageView)
        horizontalStack.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            mealImageView.heightAnchor.constraint(equalToConstant: 50),
            mealImageView.widthAnchor.constraint(equalTo: mealImageView.heightAnchor)
        ])
    }
}

