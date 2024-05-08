//
//  BottomBarView.swift
//  WeatherApp
//
//  Created by Arsalan on 07.05.2024.
//

import UIKit
import SnapKit

final class BottomBarView: UIView {
    
    //  MARK: - Properties
    private let dividerView = UIView()
    private let cityListButton = UIButton()
    
    //  MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightBlue
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 15
        
        setupDividerView()
        setupCityListButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Private Methods
    private func setupDividerView() {
        addSubview(dividerView)
        dividerView.backgroundColor = .white.withAlphaComponent(0.3)
        
        dividerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupCityListButton() {
        addSubview(cityListButton)
        cityListButton.setImage(
            UIImage(
                systemName: "list.bullet",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)),
            for: .normal
        )
        cityListButton.tintColor = .white.withAlphaComponent(0.8)
        
        cityListButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
    }
}
