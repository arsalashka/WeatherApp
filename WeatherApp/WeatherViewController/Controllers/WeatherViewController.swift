//
//  ViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 07.05.2024.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    private let backgroundImage = UIImageView()
    private let titleContainer = UIView()
    private let titleView = TitleView()
    private let bottomBarView = BottomBarView()
    private let temporaryContentView = UIView()
    private let dayWeatherView = DayWeatherView()
    private let hourlyWeatherView = HourlyWeatherView()
    private let searchField = UISearchTextField()
    private let cityView = CityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupTitleContainer()
        setupTitleView()
        setupBottomBarView()
        setupTemporaryContentView()
        setupDailyWeatherView()
        setupDayWeatherView()
        setupSearchField()
        setupCityView()
    }
    
    //  MARK: - Private Methods
    private func setupImageView() {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = .sky
        backgroundImage.alpha = 0.8
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleContainer() {
        view.addSubview(titleContainer)
        
        titleContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(titleContainer.snp.width).multipliedBy(0.7)
        }
    }
    
    private func setupTitleView() {
        titleContainer.addSubview(titleView)
        titleView.setup(TitleView.TitleViewModel(title: "Current location",
                                                 subtitle: "Kansas City",
                                                 currentTemp: 65,
                                                 description: "Mostly Sunny",
                                                 minTemp: 15,
                                                 maxTemp: 25))
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBottomBarView() {
        view.addSubview(bottomBarView)
        
        bottomBarView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(60)
        }
    }
    
    private func setupTemporaryContentView() {
        view.addSubview(temporaryContentView)
        temporaryContentView.backgroundColor = .black
        temporaryContentView.layer.borderWidth = 1
        temporaryContentView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        temporaryContentView.layer.cornerRadius = 15
        
        temporaryContentView.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setupDailyWeatherView() {
        temporaryContentView.addSubview(dayWeatherView)
        dayWeatherView.setup(
            DayWeatherView.DataModel(title: "Now",
                                     image: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                     minTemp: 15,
                                     maxTemp: 32,
                                     minDayTemp: 19,
                                     maxDayTemp: 30,
                                     currentTemp: 28)
        )
        
        dayWeatherView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupDayWeatherView() {
        temporaryContentView.addSubview(hourlyWeatherView)
        
        var models: [HourlyWeatherView.DataModel] = []
        let hours = ["Now", "12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "1"]
        let icons = ["sun.rain.fill", "cloud.sun.rain.fill","sun.max.fill", "sun.max.fill", "cloud.sun.fill", "cloud.sun.fill",
                     "sun.max.fill", "sun.max.fill", "sun.max.fill", "sun.max.fill", "sun.max.fill", "sun.max.fill", "sun.max.fill",
                     "sun.max.fill", "sun.max.fill"]
        let temps = [28, 28, 29, 30, 28, 27, 26, 24, 22, 18, 18, 17, 17, 16, 16]
        
        for index in 0..<hours.count {
            models.append(HourlyWeatherView.DataModel(
                hour: hours[index],
                icon: UIImage(systemName: icons[index])?.withRenderingMode(.alwaysOriginal),
                temp: temps[index]))
        }
        
        hourlyWeatherView.setup(models)
        
        hourlyWeatherView.snp.makeConstraints { make in
            make.top.equalTo(dayWeatherView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
    
    private func setupSearchField() {
        temporaryContentView.addSubview(searchField)
        
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
            make.top.equalTo(hourlyWeatherView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func setupCityView() {
        temporaryContentView.addSubview(cityView)
        cityView.setup(CityView.InputModel(
            title: "Current location",
            subtitle: "Kansas City",
            description: "Mostly Sunny",
            minTemp: 19,
            maxTemp: 32,
            currentTemp: 28))
        
        cityView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
