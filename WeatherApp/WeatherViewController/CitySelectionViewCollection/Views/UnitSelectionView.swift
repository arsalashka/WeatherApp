//
//  DatePicker.swift
//  WeatherApp
//
//  Created by Arsalan on 11.05.2024.
//

import UIKit
import SnapKit

final class UnitSelectionView: UIView {
    
    private enum TempUnit: Int, CaseIterable {
        case Celsius
        case Fahrenheit
        case Kelvin
        
        var unitLabel: String {
            switch self {
            case .Celsius:      return "Celsius"
            case .Fahrenheit:   return "Fahrenheit"
            case .Kelvin:       return "Kelvin"
            }
        }
    }
    
    private var tempUnitSelected = TempUnit.Celsius
    private let pickerView = UIPickerView()
    private let numberOfPickerViewComponents = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPickerView() {
        addSubview(pickerView)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension UnitSelectionView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        numberOfPickerViewComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        TempUnit.allCases.count
    }
}

extension UnitSelectionView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        pickerLabel.text = TempUnit.allCases[row].unitLabel
        pickerLabel.font = .systemFont(ofSize: 15, weight: .medium)
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .white
        pickerLabel.backgroundColor = .white.withAlphaComponent(0.8)
        pickerLabel.layer.cornerRadius = 8
        pickerLabel.layer.masksToBounds = true
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        TempUnit.allCases[row].unitLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempUnitSelected = .allCases[row]
        print(tempUnitSelected.unitLabel)
    }
}

