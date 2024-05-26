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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tempStackView = UIStackView()
    private let cityView = CityView()
    private let unitSelectionView = UnitSelectionView()
    private let searchResultController = SearchResultViewController()

    
    //  MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        presentCityWeatherViewController(with: MOCKData.data.first, animated: false)
        
        setupNavigationBar()
        setupSearchController()
        setupScrollView()
        setupStackView()
        setupUnitSelectionView()
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
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
            make.height.equalTo(1500)
        }
    }
    
    private func setupStackView() {
        contentView.addSubview(tempStackView)
        tempStackView.axis = .vertical
        tempStackView.spacing = 12
        
        MOCKData.data.forEach { data in
            let cityView = CityView()
            
            cityView.setup(CityView.InputModel(title: data.titleData.title,
                                               subtitle: data.titleData.subtitle,
                                               description: data.titleData.description,
                                               minTemp: data.titleData.minTemp,
                                               maxTemp: data.titleData.maxTemp,
                                               currentTemp: data.titleData.currentTemp))
            
            cityView.tapAction = { [weak self] in self?.presentCityWeatherViewController(with: data) }
            tempStackView.addArrangedSubview(cityView)
        }
        
        tempStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
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
