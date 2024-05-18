//
//  CityWeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 17.05.2024.
//

import UIKit
import SnapKit

final class CityWeatherDetailsViewController: UIViewController {
    
    private enum Constants: String {
        case icon = "cloud.sun"
        case labelText = "Conditions"
        case rightBarButtonItemImage = "x.circle.fill"
    }
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupNavigationBarTitleView()
        setupNavigationBarDismissButton()
    }
    
//    MARK: - Private Methods
    private func setupNavigationBarTitleView() {
        imageView.image = UIImage(systemName: Constants.icon.rawValue)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        label.text = Constants.labelText.rawValue
        label.textColor = .white
        
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        navigationItem.titleView = stackView
    }
    
    private func setupNavigationBarDismissButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.rightBarButtonItemImage.rawValue)?
                .applyingSymbolConfiguration(.init(hierarchicalColor: .white))?
                .applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 20))),
            style: .plain,
            target: self,
            action: #selector(closeButtonPressed)
        )
    }
    
//    MARK: - @objc Methods
    @IBAction func closeButtonPressed() {
        dismiss(animated: true)
    }
}
