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
        case urlString = "https://meteoinfo.ru/t-scale"
        case titleLabelText = "Weather"
        case searchFieldPlaceholder = "Search for a city or airport"
        case rightViewOfSearchField = "list.bullet"
        case unitSelectionButtonShowTitle = "Show UnitSelectionView"
        case unitSelectionButtonHideTitle = "Hide UnitSelectionView"
        case showWebViewButtonTitle = "Show Info"
    }
    
    private enum CityViewTempConstants: Int {
        case minTemp = 19
        case maxTemp = 32
        case currentTemp = 28
    }
    
    //  MARK: - Properties
    private let titleLabel = UILabel()
    private let searchField = UISearchTextField()
    private let cityView = CityView()
    private let editUnitSelectionButton = UIButton()
    private let unitSelectionView = UnitSelectionView()
    private let showWebViewButton = UIButton()
    
    //  MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupTitleLabel()
        setupSearchField()
        setupCityView()
        setupEditUnitSelectionButton()
        setupShowWebViewButton()
        setupUnitSelectionView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !unitSelectionView.isHidden {
            editUnitSelectionButtonPressed()
        }
        searchField.endEditing(true)
    }
    
    //  MARK: - Private Methods
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = Constants.titleLabelText.rawValue
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .white
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupSearchField() {
        view.addSubview(searchField)
        
        let tintColor = UIColor.white.withAlphaComponent(0.5)
        searchField.attributedPlaceholder = NSAttributedString(
            string: Constants.searchFieldPlaceholder.rawValue,
            attributes: [.foregroundColor: tintColor]
        )
        searchField.backgroundColor = .white.withAlphaComponent(0.1)
        searchField.tintColor = .white
        searchField.leftView?.tintColor = tintColor
        
        let rightView = UIButton()
        rightView.setImage(UIImage(systemName: Constants.rightViewOfSearchField.rawValue), for: .normal)
        rightView.tintColor = tintColor
        
        rightView.addAction(UIAction {_ in
            print(#function)
        }, for: .touchUpInside)
        
        searchField.rightView = rightView
        searchField.rightViewMode = .unlessEditing
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func setupCityView() {
        view.addSubview(cityView)
        cityView.setup(CityView.InputModel(
            title: Constants.title.rawValue,
            subtitle: Constants.subtitle.rawValue,
            description: Constants.description.rawValue,
            minTemp: CityViewTempConstants.minTemp.rawValue,
            maxTemp: CityViewTempConstants.maxTemp.rawValue,
            currentTemp: CityViewTempConstants.currentTemp.rawValue))
        
        cityView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupEditUnitSelectionButton() {
        view.addSubview(editUnitSelectionButton)
        editUnitSelectionButton.setTitle(Constants.unitSelectionButtonShowTitle.rawValue, for: .normal)
        editUnitSelectionButton.backgroundColor = .white.withAlphaComponent(0.4)
        editUnitSelectionButton.layer.cornerRadius = 8
        
        editUnitSelectionButton.addTarget(
            self,
            action: #selector(editUnitSelectionButtonPressed),
            for: .touchUpInside
        )
        
        editUnitSelectionButton.snp.makeConstraints { make in
            make.top.equalTo(cityView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(210)
        }
    }
    
    private func setupShowWebViewButton() {
        view.addSubview(showWebViewButton)
        showWebViewButton.setTitle(Constants.showWebViewButtonTitle.rawValue, for: .normal)
        showWebViewButton.backgroundColor = .white.withAlphaComponent(0.4)
        showWebViewButton.layer.cornerRadius = 8
        
        showWebViewButton.addTarget(
            self,
            action: #selector(showWebViewButtonPressed),
            for: .touchUpInside
        )
        
        showWebViewButton.snp.makeConstraints { make in
            make.top.equalTo(editUnitSelectionButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(210)
        }
    }
    
    private func setupUnitSelectionView() {
        view.addSubview(unitSelectionView)
        unitSelectionView.isHidden = true
        
        unitSelectionView.snp.makeConstraints { make in
            make.top.equalTo(showWebViewButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
    }
    
    //  MARK: - Button Pressed Methods
    @IBAction func editUnitSelectionButtonPressed() {
        unitSelectionView.isHidden  = unitSelectionView.isHidden ? false : true
        editUnitSelectionButton.setTitle(
            unitSelectionView.isHidden ? Constants.unitSelectionButtonShowTitle.rawValue : Constants.unitSelectionButtonHideTitle.rawValue,
            for: .normal
        )
    }
    
    @IBAction func showWebViewButtonPressed() {
        let webVC = WebViewController()
        
        if let url = URL(string: Constants.urlString.rawValue) {
            webVC.open(url)
        }
        
        present(webVC, animated: true)
    }
}
