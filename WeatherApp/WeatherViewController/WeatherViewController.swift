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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupTitleContainer()
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
    
    
}

#Preview {
    WeatherViewController()
}
