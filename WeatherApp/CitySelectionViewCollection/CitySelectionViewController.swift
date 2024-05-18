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
        case title = "Current location"
        case subtitle = "Kansas City"
        case description = "Mostly Sunny"
        case searchBarPlaceholder = "Search for a city or airport"
        case showWebViewButtonTitle = "Show Info"
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
    private let cityView = CityView()
    private let editUnitSelectionButton = UIButton()
    private let unitSelectionView = UnitSelectionView()
    private let showWebViewButton = UIButton()
    
    //  MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        showCityWeatherViewController()
        
        setupNavigationBar()
        setupSearchController()
        setupScrollView()
        setupCityView()
        setupShowWebViewButton()
        setupUnitSelectionView()
    }
    
    //  MARK: - Private Methods
    private func showCityWeatherViewController() {
        let cityWeatherViewController = CityWeatherViewController()
        self.navigationController?.pushViewController(cityWeatherViewController, animated: true)
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        
        title = Constants.navigationBarTitleText.rawValue
        navigationBar?.prefersLargeTitles = true
        navigationBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonItemPressed)
        )
    }
    
    private func setupSearchController() {
        let searchResultController = SearchResultViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchResultsUpdater = searchResultController
        searchController.showsSearchResultsController = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder.rawValue
        searchController.searchBar.delegate = self
        searchController.searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
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
    
    private func setupCityView() {
        contentView.addSubview(cityView)
        cityView.setup(CityView.InputModel(
            title: Constants.title.rawValue,
            subtitle: Constants.subtitle.rawValue,
            description: Constants.description.rawValue,
            minTemp: CityViewTempConstants.minTemp.rawValue,
            maxTemp: CityViewTempConstants.maxTemp.rawValue,
            currentTemp: CityViewTempConstants.currentTemp.rawValue))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cityViewTapped(_:)))
        cityView.addGestureRecognizer(tap)
        
        cityView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupShowWebViewButton() {
        contentView.addSubview(showWebViewButton)
        showWebViewButton.setTitle(Constants.showWebViewButtonTitle.rawValue, for: .normal)
        showWebViewButton.backgroundColor = .white.withAlphaComponent(0.4)
        showWebViewButton.layer.cornerRadius = 8
        
        showWebViewButton.addTarget(
            self,
            action: #selector(showWebViewButtonPressed),
            for: .touchUpInside
        )
        
        showWebViewButton.snp.makeConstraints { make in
            make.top.equalTo(cityView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(210)
        }
    }
    
    private func setupUnitSelectionView() {
        contentView.addSubview(unitSelectionView)
        unitSelectionView.isHidden = true
        
        unitSelectionView.snp.makeConstraints { make in
            make.top.equalTo(showWebViewButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
    }
    
    //  MARK: - Button Pressed Methods
    @IBAction func rightBarButtonItemPressed() {
        unitSelectionView.isHidden  = unitSelectionView.isHidden ? false : true
    }
    
    @IBAction func showWebViewButtonPressed() {
        let webViewController = WebViewController()
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @IBAction func cityViewTapped(_ sender: UITapGestureRecognizer? = nil) {
        showCityWeatherViewController()
    }
}

//  MARK: - Extensions
extension CitySelectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}
