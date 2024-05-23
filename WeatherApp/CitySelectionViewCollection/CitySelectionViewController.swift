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
    private let tempStackView = UIStackView()
    private let cityView = CityView()
    private let unitSelectionView = UnitSelectionView()
    private let showWebViewButton = UIButton()
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
        
        setupShowWebViewButton()
        setupUnitSelectionView()
    }
    
    //  MARK: - Private Methods
    private func presentCityWeatherViewController(with data: MOCKData?, animated: Bool = true) {
        let cityWeatherViewController = CityWeatherViewController()
        
        cityWeatherViewController.modalPresentationStyle = .fullScreen
        
        if let data {
            cityWeatherViewController.setup(data)
        }
        present(cityWeatherViewController, animated: true)
//        navigationController?.pushViewController(cityWeatherViewController, animated: true)
        
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
    
    
    
    
//    private func setupCityView() {
//        contentView.addSubview(cityView)
//        cityView.setup(CityView.InputModel(
//            title: Constants.title.rawValue,
//            subtitle: Constants.subtitle.rawValue,
//            description: Constants.description.rawValue,
//            minTemp: CityViewTempConstants.minTemp.rawValue,
//            maxTemp: CityViewTempConstants.maxTemp.rawValue,
//            currentTemp: CityViewTempConstants.currentTemp.rawValue))
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(cityViewTapped(_:)))
//        cityView.addGestureRecognizer(tap)
//        
//        cityView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(16)
//            make.horizontalEdges.equalToSuperview().inset(16)
//        }
//    }
    
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
            make.top.equalTo(tempStackView.snp.bottom).offset(16)
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
    @IBAction private func rightBarButtonItemPressed() {
        unitSelectionView.isHidden  = unitSelectionView.isHidden ? false : true
    }
    
    @IBAction private func showWebViewButtonPressed() {
        let webViewController = WebViewController()
        
        navigationController?.pushViewController(webViewController, animated: true)
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
