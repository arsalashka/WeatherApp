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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupTitleContainer()
        setupTitleView()
        

    }
    
    private func setupImageView() {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "sky")
        
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
}

#Preview {
    WeatherViewController()
}
