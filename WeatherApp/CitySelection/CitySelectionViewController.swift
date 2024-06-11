//
//  CitySelectionViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 10.05.2024.
//

import UIKit
import SnapKit

extension CitySelectionViewController {
    typealias Section = CitySelectionViewModel.Section
    typealias Item = CityWeatherData
    
    //  MARK: - Constants
    private enum Constants: String {
        case searchBarPlaceholder = "Search for a city or airport"
        case navigationBarTitleText = "Weather"
        case webViewTitle1 = "Meteorological data"
        case webViewTitle2 = "Info"
    }
}

final class CitySelectionViewController: UIViewController {
    //  MARK: - Properties
    var viewModel: CitySelectionViewModelInput?
    var sections: [Section] = [] {
        didSet {
            reloadDataSource()
        }
    }
    
    private var collectionView: UICollectionView!
    private let unitSelectionView = UnitSelectionView()

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>! = nil
    
    //  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = APIEndpointProvider()
        
        
        view.backgroundColor = .black
        
        viewModel?.output = self
        viewModel?.viewDidLoad()
        
        setupNavigationBar()
        setupSearchController()
        setupUnitSelectionView()
        setupCollectionView()
        
        createDataSource()
        reloadDataSource()
        
        presentCityWeatherViewController(with: sections.first?.items.first, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height else { return }
        unitSelectionView.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight + 50)
        }
    }
    
    //  MARK: - Private Methods
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())

        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self

        collectionView.registerCell(CityViewCell.self)
        collectionView.registerView(InfoFooter.self, ofKind: UICollectionView.elementKindSectionFooter)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [self] sectionIndex, _ in
            return createCitySection()
        }
        
        return layout
    }
    
    private func createCitySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        let layoutSectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        layoutSection.boundarySupplementaryItems = [layoutSectionFooter]
        layoutSection.interGroupSpacing = 12
        
        return layoutSection
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return nil }
            
            let item = sections[indexPath.section].items[indexPath.row]
            let cell = collectionView.dequeueCell(CityViewCell.self, for: indexPath)
            cell.setup(item.titleData)
            
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self else { return UICollectionReusableView() }
            
            switch kind {
            case UICollectionView.elementKindSectionFooter:
                let sectionFooter = collectionView.dequeueView(InfoFooter.self, ofKind: kind, for: indexPath)
                sectionFooter.setup(sections[indexPath.section].footerAttributedString)
                sectionFooter.linkAction = { [self] url in
                    self.navigationController?.pushViewController(WebViewController(with: Constants.webViewTitle1.rawValue), animated: true)
                }
                return sectionFooter
            default:
                return nil
            }
        }
    }
    
    private func reloadDataSource() {
        snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func presentCityWeatherViewController(with data: CityWeatherData?, animated: Bool = true) {
        let cityWeatherViewController = CityWeatherViewController()
        
        cityWeatherViewController.viewModel = CityWeatherViewModel(weatherData: data)
        cityWeatherViewController.modalPresentationStyle = .fullScreen
      
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
        let searchResultController = CitySearchViewController()
        searchResultController.viewModel = CitySearchViewModel(cityListProvider: CityListProviderImpl())
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
    
    //  MARK: - Button Pressed Methods
    @IBAction private func rightBarButtonItemPressed() {
        unitSelectionView.isHidden  = unitSelectionView.isHidden ? false : true
    }
}

//  MARK: - UISearchBarDelegate
extension CitySelectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
        
        let webViewController = WebViewController(with: Constants.webViewTitle2.rawValue)
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

//  MARK: - UICollectionViewDelegate
extension CitySelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentCityWeatherViewController(with: sections[indexPath.section].items[indexPath.row])
    }
}

//  MARK: - CitySelectionViewModelOutput
extension CitySelectionViewController: CitySelectionViewModelOutput {
}
