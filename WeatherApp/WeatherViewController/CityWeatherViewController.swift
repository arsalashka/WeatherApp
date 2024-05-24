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
    private enum Constants: String {
        case showDetailsButtonTitle = "Show Details"
    }
    
    //  MARK: - Properties
    private let backgroundImage = UIImageView()
    private let titleContainer = UIView()
    private let titleView = TitleView()
    private let bottomBarView = BottomBarView()
    private let temporaryContentView = UIView()
    private let dayHourlyWeatherView = DayHourlyWeatherView()
    private let dailyWeatherView = DailyWeatherView()
    private let showDetailsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupImageView()
        setupTitleContainer()
        setupTitleView()
        setupBottomBarView()
        setupTemporaryContentView()
        setupDayHourlyWeatherView()
        setupDailyWeatherView()
        setupShowDetailsButton()
    }
    
    //  MARK: - Public Methods
    func setup(_ data: MOCKData) {
        titleView.setup(data.titleData)
        dayHourlyWeatherView.setup(description: data.dayHourlyData.description, data: data.dayHourlyData.data)
        dailyWeatherView.setup(data.dayData.first)
    }

    
    //  MARK: - Private Methods
    private func setupImageView() {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = .sky
        
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
       
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBottomBarView() {
        view.addSubview(bottomBarView)
        
        bottomBarView.cityListButtonPressed = { [weak self] in
            self?.dismiss(animated: true)
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
    
    private func setupDayHourlyWeatherView() {
        temporaryContentView.addSubview(dayHourlyWeatherView)
        
        dayHourlyWeatherView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupDailyWeatherView() {
        temporaryContentView.addSubview(dailyWeatherView)
        
        dailyWeatherView.snp.makeConstraints { make in
            make.top.equalTo(dayHourlyWeatherView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupShowDetailsButton() {
        temporaryContentView.addSubview(showDetailsButton)
        
        showDetailsButton.setTitle(Constants.showDetailsButtonTitle.rawValue, for: .normal)
        showDetailsButton.titleLabel?.textColor = .white
        showDetailsButton.backgroundColor = .darkBlue
        showDetailsButton.layer.cornerRadius = 8
        
        showDetailsButton.addTarget(self, action: #selector(showDetailsButtonPressed), for: .touchUpInside)
        
        showDetailsButton.snp.makeConstraints { make in
            make.top.equalTo(dailyWeatherView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    //  MARK: - @objc Methods
    @IBAction private func showDetailsButtonPressed() {
        let cityWeatherDetailsViewController = CityWeatherDetailsViewController()
        let navigationController = UINavigationController(rootViewController: cityWeatherDetailsViewController)
        
        navigationController.modalPresentationStyle = .pageSheet
        
        let sheetViewController = navigationController.sheetPresentationController
        sheetViewController?.detents = [.medium(), .large()]
        sheetViewController?.prefersGrabberVisible = true
        sheetViewController?.largestUndimmedDetentIdentifier = .large
        sheetViewController?.selectedDetentIdentifier = .large
        
        self.present(navigationController, animated: true)
    }
}
