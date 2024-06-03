//
//  TitleCell.swift
//  WeatherApp
//
//  Created by Arsalan on 31.05.2024.
//

import UIKit
import SnapKit

final class TitleCell: UITableViewCell {
    struct InputModel {
        let imageSystemName: String
        let title: String
    }
    
//    MARK: - Properties
    static let titleCellID = "TitleCellID"
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    
//    MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupIconView()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Public Methods
    func setup(_ inputModel: InputModel) {
        iconView.image = UIImage(systemName: inputModel.imageSystemName)?
            .applyingSymbolConfiguration(.init(weight: .bold))
        titleLabel.text = inputModel.title.uppercased()
    }
    
//    MARK: - Setup UI
    private func setupIconView() {
        contentView.addSubview(iconView)
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .white.withAlphaComponent(0.5)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.textColor = .white.withAlphaComponent(0.5)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
    }
}
