//
//  SearchResultViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 18.05.2024.
//

import UIKit
import SnapKit

final class CitySearchViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cityCellID = "cell"
    
    var viewModel: CitySearchViewModelInput!
    var cityList: [City] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        setupTableView()
        
        viewModel.output = self
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cityCellID)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

//  MARK: - Extensions
extension CitySearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.searchTextField.text else { return }
        
        let searchQuery = query.lowercased()
        view.backgroundColor = .black.withAlphaComponent(searchQuery.isEmpty ? 0.5 : 1)
        
        viewModel.filterCity(with: searchQuery)
        tableView.reloadData()
    }
}

extension CitySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellID, for: indexPath)
    
        cell.textLabel?.attributedText = viewModel.getAttributedTitle(for: indexPath)
        
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage()
        
        let backGroundColorView = UIView()
        backGroundColorView.backgroundColor = .white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = backGroundColorView
        
        return cell
    }
}

extension CitySearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(cityList[indexPath.row])
    }
}

extension CitySearchViewController: CitySearchViewModelOutput {
}
