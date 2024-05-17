//
//  ViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 07.05.2024.
//

import UIKit
import SnapKit

final class CityWeatherViewController: UIViewController {
    
    //  MARK: - Constants
    private enum TitleViewConstants: Int {
        case currentTemp = 28
        case minTemp = 15
        case maxTemp = 32
    }
    
    private enum DayWeatherViewConstants: Int {
        case minTemp = 15
        case maxTemp = 32
        case minDayTemp = 19
        case maxDayTemp = 30
        case currentTemp = 28
    }
    
    //  MARK: - Properties
    private let backgroundImage = UIImageView()
    private let titleContainer = UIView()
    private let titleView = TitleView()
    private let bottomBarView = BottomBarView()
    private let temporaryContentView = UIView()
    private let dayWeatherView = DayWeatherView()
    private let hourlyWeatherView = HourlyWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupImageView()
        setupTitleContainer()
        setupTitleView()
        setupBottomBarView()
        setupTemporaryContentView()
        setupDailyWeatherView()
        setupDayWeatherView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false

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
                                                 currentTemp: TitleViewConstants.currentTemp.rawValue,
                                                 description: "Mostly Sunny",
                                                 minTemp: TitleViewConstants.minTemp.rawValue,
                                                 maxTemp: TitleViewConstants.maxTemp.rawValue))
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBottomBarView() {
        view.addSubview(bottomBarView)
        
        bottomBarView.cityListButtonPressed = { [weak self] in
//            let citySelectionVC = CitySelectionViewController()
//            
//            citySelectionVC.modalPresentationStyle = .fullScreen
//            self?.present(citySelectionVC, animated: true)
            self?.navigationController?.popViewController(animated: true)
        }
        
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
                                     minTemp: Double(DayWeatherViewConstants.minTemp.rawValue),
                                     maxTemp: Double(DayWeatherViewConstants.maxTemp.rawValue),
                                     minDayTemp: Double(DayWeatherViewConstants.minDayTemp.rawValue),
                                     maxDayTemp: Double(DayWeatherViewConstants.maxDayTemp.rawValue),
                                     currentTemp: Double(DayWeatherViewConstants.currentTemp.rawValue))
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
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
