//
//  CitySelectionViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 10.05.2024.
//

import UIKit
import SnapKit

final class CitySelectionViewController: UIViewController {
    //  MARK: - Constants
    private enum Constants: String {
        case searchBarPlaceholder = "Search for a city or airport"
        case navigationBarTitleText = "Weather"
    }
    
    private enum CityViewTempConstants: Int {
        case minTemp = 19
        case maxTemp = 32
        case currentTemp = 28
    }
    
    //  MARK: - Properties
    private let tableView = UITableView()
    private let dataSource = MOCKData.data
    
    private let unitSelectionView = UnitSelectionView()
    private let searchResultController = SearchResultViewController()

    
    //  MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupNavigationBar()
        setupSearchController()
        
        setupUnitSelectionView()
        
        setupTableView()
        
        presentCityWeatherViewController(with: MOCKData.data.first, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height {
            unitSelectionView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(statusBarHeight + 50)
            }
        }
    }
    
    //  MARK: - Private Methods
    private func presentCityWeatherViewController(with data: MOCKData?, animated: Bool = true) {
        let cityWeatherViewController = CityWeatherViewController()
        
        cityWeatherViewController.modalPresentationStyle = .fullScreen
        
        guard let saveData = data else { return }
        
        cityWeatherViewController.setup(saveData)
        present(cityWeatherViewController, animated: true)
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        
        title = Constants.navigationBarTitleText.rawValue
        navigationBar?.prefersLargeTitles = true
        navigationBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemSymbol: .ellipsisCircle)?.withTintColor(.white, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonItemPressed)
        )
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchResultsUpdater = searchResultController
        searchController.showsSearchResultsController = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder.rawValue
        searchController.searchBar.delegate = self
        searchController.searchBar.setImage(UIImage(systemSymbol: .micFill), for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
    }
    
    private func setupUnitSelectionView() {
        navigationController?.view.addSubview(unitSelectionView)
        unitSelectionView.isHidden = true
        unitSelectionView.delegate = self
        
        unitSelectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(150)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    //  MARK: - Button Pressed Methods
    @IBAction private func rightBarButtonItemPressed() {
        unitSelectionView.isHidden  = unitSelectionView.isHidden ? false : true
    }
}

//  MARK: - UISearchBarDelegate
extension CitySelectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

//  MARK: - UnitSelectionViewDelegate
extension CitySelectionViewController: UnitSelectionViewDelegate {
    func didSelectUnit(_ unit: TempUnit) {
        unitSelectionView.isHidden = true
        print(unit.unitLabel)
    }
    
    func showUnitInfo() {
        unitSelectionView.isHidden = true
        
        let webViewController = WebViewController()
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

//  MARK: - UITableViewDataSource
extension CitySelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = dataSource[indexPath.row]
        let cityView = CityView()
        
        cityView.setup(CityView.InputModel(
            title: data.titleData.title,
            subtitle: data.titleData.subtitle,
            description: data.titleData.description,
            minTemp: data.titleData.minTemp,
            maxTemp: data.titleData.maxTemp,
            currentTemp: data.titleData.currentTemp)
        )
        
        cell.addSubview(cityView)
        
        cityView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
}

//  MARK: - UITableViewDelegate
extension CitySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentCityWeatherViewController(with: dataSource[indexPath.row])
    }
}
