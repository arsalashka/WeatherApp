//
//  SearchResultViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 18.05.2024.
//

import UIKit
import SnapKit

final class CitySearchViewController: UIViewController {
    
    private let cityList = [
        "Kansas", "Orlando", "New York", "Chicago", "Los Angeles",
        "Miami", "Seattle", "San Diego", "Oregon", "Atlanta"
    ]
    private let tableView = UITableView()
    private let cityCellID = "cell"
    private var filteredCityList: [String] = []
    private var searchQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        setupTableView()
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
        guard let query = searchController.searchBar.text else { return }
        
        searchQuery = query.lowercased()
        view.backgroundColor = .black.withAlphaComponent(searchQuery.isEmpty ? 0.5 : 1)
        
        filteredCityList = cityList.filter {
            $0.lowercased().contains(searchQuery)
        }
        
        tableView.reloadData()
    }
}

extension CitySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellID, for: indexPath)
        let attributedText = NSAttributedString(
            string: filteredCityList[indexPath.row],
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        
        cell.textLabel?.attributedText = attributedText
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
        print(filteredCityList[indexPath.row])
    }
}
