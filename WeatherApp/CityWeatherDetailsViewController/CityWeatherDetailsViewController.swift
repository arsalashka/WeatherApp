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
        case labelText = "Conditions"
    }
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupNavigationBarTitleView()
        setupNavigationBarDismissButton()
    }
    
//    MARK: - Private Methods
    private func setupNavigationBarTitleView() {
        imageView.image = UIImage(
            systemSymbol: .cloudSun)?
            .withTintColor(.white, renderingMode: .alwaysOriginal
            )
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
            image: UIImage(systemSymbol: .xCircleFill)?
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
        print(#file, #function, #line)
    }
}
