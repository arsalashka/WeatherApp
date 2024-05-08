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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupTitleContainer()
        setupTitleView()
        setupBottomBarView()
        setupTemporaryContentView()
        setupDayTempLimitsView()
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
        temporaryContentView.backgroundColor = .black
        temporaryContentView.layer.borderWidth = 1
        temporaryContentView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        temporaryContentView.layer.cornerRadius = 15
        
        temporaryContentView.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
//            TODO: delete this constraint
            make.height.equalTo(60)
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
}

//#Preview {
//    WeatherViewController()
//}
