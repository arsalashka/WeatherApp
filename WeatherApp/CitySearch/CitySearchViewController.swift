//
//  SearchResultViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 18.05.2024.
//

import UIKit
import SnapKit
import CoreData

protocol CitySearchViewControllerDelegate: AnyObject {
    func reloadData()
}

final class CitySearchViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cityCellID = "cell"
    
    weak var delegate: CitySearchViewControllerDelegate?
    var viewModel: CitySearchViewModelInput!
    var cityList: [CityData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchQuery: String = ""
    
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
    
    private func getAttributedTitle(for indexPath: IndexPath) -> NSAttributedString? {
        let city = cityList[indexPath.row]
        
        var title = "\(city.name), \(city.country)"
        if !city.state.isEmpty {
            title += ", \(city.state)"
        }
        
        let attributedText = NSMutableAttributedString(
            string: title,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        
        let queryRange = (title.lowercased() as NSString).range(of: searchQuery)
        attributedText.addAttributes([.foregroundColor: UIColor.white], range: queryRange)
        
        return attributedText
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
    
        cell.textLabel?.attributedText = getAttributedTitle(for: indexPath)
        
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
        viewModel.select(cityList[indexPath.row])
        delegate?.reloadData()
        dismiss(animated: true)
    }
}

extension CitySearchViewController: CitySearchViewModelOutput {
}
