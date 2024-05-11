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
    private enum CityViewConstants: Int {
        case minTemp = 19
        case maxTemp = 32
        case currentTemp = 28
    }
    
    //  MARK: - Properties
    private let titleLabel = UILabel()
    private let searchField = UISearchTextField()
    private let cityView = CityView()
    private let editUnitSelectionButton = UIButton()
    private let unitSelectionView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupTitleLabel()
        setupSearchField()
        setupCityView()
        setupEditUnitSelectionButton()
        setupUnitSelectionView()
    }
    
    //  MARK: - Private Methods
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Weather"
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
            string: "Search for a city or airport",
            attributes: [.foregroundColor: tintColor]
        )
        searchField.backgroundColor = .white.withAlphaComponent(0.1)
        searchField.tintColor = .white
        searchField.leftView?.tintColor = tintColor
        
        let rightView = UIButton()
        rightView.setImage(UIImage(systemName: "list.bullet"), for: .normal)
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
            title: "Current location",
            subtitle: "Kansas City",
            description: "Mostly Sunny",
            minTemp: CityViewConstants.minTemp.rawValue,
            maxTemp: CityViewConstants.maxTemp.rawValue,
            currentTemp: CityViewConstants.currentTemp.rawValue))
        
        cityView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupEditUnitSelectionButton() {
        view.addSubview(editUnitSelectionButton)
        editUnitSelectionButton.setTitle("Hide UnitSelectionView", for: .normal)
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
    
    private func setupUnitSelectionView() {
        view.addSubview(unitSelectionView)
        unitSelectionView.backgroundColor = .purple
        unitSelectionView.layer.cornerRadius = 12
        
        unitSelectionView.snp.makeConstraints { make in
            make.top.equalTo(editUnitSelectionButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    //  MARK: - IBActions
    @IBAction func editUnitSelectionButtonPressed() {
        
        if unitSelectionView.isHidden {
            unitSelectionView.isHidden = false
            editUnitSelectionButton.setTitle("Hide UnitSelectionView", for: .normal)
        } else {
            unitSelectionView.isHidden = true
            editUnitSelectionButton.setTitle("Show UnitSelectionView", for: .normal)
        }
    }
}
