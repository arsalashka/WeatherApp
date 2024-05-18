//
//  SearchResultViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 18.05.2024.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    private let defaultCities = ["Kansas", "Orlando", "New York", "Chicago", "Los Angeles"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }
}

//  MARK: - Extensions
extension SearchResultViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        view.backgroundColor = .black.withAlphaComponent(text.isEmpty ? 0.5 : 1)
        
        let filteredList = defaultCities.filter {
            $0.contains(text)
        }
        print(filteredList)
    }
}
