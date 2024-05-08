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
    private let dayTempLimitsView = DayTempLimitsView()
    private let hourlyWeatherView = HourlyWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupTitleContainer()
        setupTitleView()
        setupBottomBarView()
        setupTemporaryContentView()
        setupDayTempLimitsView()
        setupDayWeatherView()
    }
    
    private func setupImageView() {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "sky")
        backgroundImage.alpha = 0.8
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleContainer() {
        view.addSubview(titleContainer)
//        titleContainer.backgroundColor = .black
        
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
        temporaryContentView.backgroundColor = UIColor(named: "lightBlue")?.withAlphaComponent(0.8)
        temporaryContentView.layer.borderWidth = 1
        temporaryContentView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        temporaryContentView.layer.cornerRadius = 15
        
        temporaryContentView.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
//            TODO: delete this constraint
//            make.height.equalTo(60)
        }
    }
    
    private func setupDayTempLimitsView() {
        temporaryContentView.addSubview(dayTempLimitsView)
        dayTempLimitsView.setup(DayTempLimitsView.DataModel(minWeekTemp: 15,
                                                            maxWeekTemp: 32,
                                                            minDayTemp: 19,
                                                            maxDayTemp: 30,
                                                            currentTemp: 28)
                                )
        
        dayTempLimitsView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.width.equalTo(200)
        }
    }
    
    private func setupDayWeatherView() {
        temporaryContentView.addSubview(hourlyWeatherView)
        
        hourlyWeatherView.setup([
            HourlyWeatherView.DataModel(hour: "Now",
                                        icon: UIImage(systemName: "sun.rain.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 28),
            HourlyWeatherView.DataModel(hour: "12",
                                        icon: UIImage(systemName: "cloud.sun.rain.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 28),
            HourlyWeatherView.DataModel(hour: "1",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 29),
            HourlyWeatherView.DataModel(hour: "2",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 30),
            HourlyWeatherView.DataModel(hour: "3",
                                        icon: UIImage(systemName: "cloud.sun.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 28),
            HourlyWeatherView.DataModel(hour: "4",
                                        icon: UIImage(systemName: "cloud.sun.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 27),
            HourlyWeatherView.DataModel(hour: "5",
                                        icon: UIImage(systemName: "sun.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 26),
            HourlyWeatherView.DataModel(hour: "6",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 22),
            HourlyWeatherView.DataModel(hour: "7",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 18),
            HourlyWeatherView.DataModel(hour: "8",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 18),
            HourlyWeatherView.DataModel(hour: "9",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 17),
            HourlyWeatherView.DataModel(hour: "10",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 17),
            HourlyWeatherView.DataModel(hour: "11",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 17),
            HourlyWeatherView.DataModel(hour: "12",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 17),
            HourlyWeatherView.DataModel(hour: "1",
                                        icon: UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal),
                                        temp: 16),
        ])
        
        hourlyWeatherView.snp.makeConstraints { make in
            make.top.equalTo(dayTempLimitsView.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
}
