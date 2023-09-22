//
//  MealsViewController.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import UIKit

final class MealsViewController: UIViewController {
    let refresh = UIRefreshControl()
    lazy var mealsTableView: UITableView = {
        let tableView = UITableView()
        tableView.refreshControl = refresh
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let mealsService: MealsServiceProtocol
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await fetchDesserts()
        }
    }
    
    init(mealsService: MealsServiceProtocol = MealsService()) {
        self.mealsService = mealsService
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleRefreshControl() {
        Task { [weak self] in
            await self?.fetchDesserts()
        }
    }
}

private extension MealsViewController {
    func setupUI() {
        title = LocalizedString.mealsTitle.localized
        view.backgroundColor = .systemBackground
        
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        mealsTableView.register(MealCell.self, forCellReuseIdentifier: Constants.mealCell)
        view.addSubview(mealsTableView)
        NSLayoutConstraint.activate([
            mealsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mealsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mealsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mealsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchDesserts() async {
        defer { mealsTableView.refreshControl?.endRefreshing() }
        mealsTableView.refreshControl?.beginRefreshing()
        adjustScrollForRefreshing()
        do {
            meals = try await mealsService.fetchDesserts()
            mealsTableView.reloadData()
        } catch {
            presentAlert(withMessage: error.localizedDescription)
        }
    }
    
    func adjustScrollForRefreshing() {
        guard let refreshControlHeight = mealsTableView.refreshControl?.frame.size.height else { return }
        let tableViewOffset = mealsTableView.contentOffset.y
        mealsTableView.setContentOffset(.init(x: .zero, y: tableViewOffset - refreshControlHeight), animated: true)
    }
    
    func presentAlert(withMessage message: String) {
        let retry = UIAlertAction(title: LocalizedString.retryButton.localized, style: .default) { [weak self] _ in
            Task { [weak self] in
                await self?.fetchDesserts()
            }
        }
        let cancel = UIAlertAction(title: LocalizedString.cancelButton.localized, style: .cancel)
        let alert = UIAlertController(title: LocalizedString.errorAlertTitle.localized, message: message, preferredStyle: .alert)
        alert.addAction(retry)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension MealsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mealCell, for: indexPath) as? MealCell,
              let meal = meals[safe: indexPath.row] else {
            return MealCell()
        }
        cell.setup(meal)
        return cell
    }
}

extension MealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nav = navigationController, let meal = meals[safe: indexPath.row] else { return }
        let vc = MealDetailViewController(meal: meal)
        nav.pushViewController(vc, animated: true)
    }
}
