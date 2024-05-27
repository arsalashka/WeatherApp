//
//  DatePicker.swift
//  WeatherApp
//
//  Created by Arsalan on 11.05.2024.
//

import UIKit
import SnapKit

protocol UnitSelectionViewDelegate: AnyObject {
    func didSelectUnit(_ unit: TempUnit)
    func showUnitInfo()
}

enum TempUnit: Int, CaseIterable {
    case Celsius
    case Fahrenheit
    case Kelvin
    
    var unitLabel: String {
        switch self {
        case .Celsius: return "Celsius"
        case .Fahrenheit: return "Fahrenheit"
        case .Kelvin: return "Kelvin"
        }
    }
}

final class UnitSelectionView: UIView {
    
    private enum Constants: Int {
        case numberOfPickerViewComponents = 1
        case rowHeightForComponent = 40
    }
    
    private let pickerView = UIPickerView()
    private let infoButton = UIButton()
    
    weak var delegate: UnitSelectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .customDarkGray.withAlphaComponent(0.9)
        layer.cornerRadius = 16
        
        setupPickerView()
        setupInfoButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Private Methods
    private func setupPickerView() {
        addSubview(pickerView)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupInfoButton() {
        addSubview(infoButton)
        
        infoButton.setImage(
            UIImage(systemSymbol: .questionmarkCircle)?
                .applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 22))),
            for: .normal
        )
        infoButton.tintColor = .white.withAlphaComponent(0.8)
        
        infoButton.addAction(UIAction { [weak self] _ in
            self?.delegate?.showUnitInfo()
        }, for: .touchUpInside)
        
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(16)
            make.bottom.trailing.equalToSuperview().inset(16)
            make.size.equalTo(20)
        }
    }
}

//  MARK: - UIPickerViewDataSource
extension UnitSelectionView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfPickerViewComponents.rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        TempUnit.allCases.count
    }
}

//  MARK: - UIPickerViewDelegate
extension UnitSelectionView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        pickerLabel.text = TempUnit.allCases[row].unitLabel
        pickerLabel.font = .systemFont(ofSize: 15, weight: .medium)
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .white
        pickerLabel.backgroundColor = .white.withAlphaComponent(0.2)
        pickerLabel.layer.cornerRadius = 8
        pickerLabel.layer.masksToBounds = true
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        CGFloat(Constants.rowHeightForComponent.rawValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        TempUnit.allCases[row].unitLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.didSelectUnit(TempUnit.allCases[row])
    }
}
