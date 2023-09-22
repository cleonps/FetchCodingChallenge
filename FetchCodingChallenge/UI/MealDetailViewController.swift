//
//  MealDetailViewController.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import UIKit

final class MealDetailViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let mealImageLoader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5.0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let ingredientsLabel = MealLabel(numberOfLines: 0)
    let instructionsLabel = MealLabel(numberOfLines: 0)
    let fillerView = UIView(frame: .zero)
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    let mealsService: MealsServiceProtocol
    var meal: Meal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Task {
            await fetchMeal(byId: meal.idMeal)
        }
    }
    
    init(meal: Meal, mealsService: MealsServiceProtocol = MealsService()) {
        self.meal = meal
        self.mealsService = mealsService
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MealDetailViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        title = meal.strMeal
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.addSubview(contenView)
        let heightConstraint = contenView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250.0)
        NSLayoutConstraint.activate([
            contenView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contenView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint
        ])
        
        contenView.addSubview(mealImageView)
        contenView.addSubview(mealImageLoader)
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: contenView.topAnchor),
            mealImageView.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            mealImageView.widthAnchor.constraint(equalToConstant: 250),
            mealImageView.heightAnchor.constraint(equalTo: mealImageView.widthAnchor),
            mealImageLoader.topAnchor.constraint(equalTo: contenView.topAnchor),
            mealImageLoader.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            mealImageLoader.widthAnchor.constraint(equalToConstant: 250),
            mealImageLoader.heightAnchor.constraint(equalTo: mealImageLoader.widthAnchor)
        ])
        contenView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 10.0),
            contentStackView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 10.0),
            contentStackView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -10.0),
            contentStackView.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -10.0)
        ])
        
        let arrangedSubViews = [ingredientsLabel, instructionsLabel, fillerView]
        arrangedSubViews.forEach { contentStackView.addArrangedSubview($0) }
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fetchMeal(byId id: String) async {
        defer { activityIndicator.stopAnimating() }
        activityIndicator.startAnimating()
        do {
            meal = try await mealsService.fetchDessert(byId: id)
            updateUI()
        } catch {
            presentAlert(withMessage: error.localizedDescription)
        }
    }
    
    func updateUI() {
        setupLabel(ingredientsLabel, format: LocalizedString.ingredientsLabel.localized, text: meal.getIngredientsWithMeasure())
        setupLabel(instructionsLabel, format: LocalizedString.instructionsLabel.localized, text: meal.strInstructions)
        
        guard let url = URL(string: meal.strMealThumb) else { return }
        mealImageLoader.startAnimating()
        Task.detached {
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            await self.updateImage(with: image)
        }
    }
    
    func setupLabel(_ label: UILabel, format: String, text: String?) {
        if let text {
            label.text = String(format: format, text)
        } else {
            label.isHidden = true
        }
    }
    
    @MainActor
    func updateImage(with image: UIImage?) async {
        mealImageLoader.stopAnimating()
        mealImageView.image = image
    }
    
    func presentAlert(withMessage message: String) {
        let retry = UIAlertAction(title: LocalizedString.retryButton.localized, style: .default) { [weak self] _ in
            Task { [weak self] in
                guard let self else { return }
                await fetchMeal(byId: meal.idMeal)
            }
        }
        let cancel = UIAlertAction(title: LocalizedString.cancelButton.localized, style: .cancel)
        let alert = UIAlertController(title: LocalizedString.errorAlertTitle.localized, message: message, preferredStyle: .alert)
        alert.addAction(retry)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
