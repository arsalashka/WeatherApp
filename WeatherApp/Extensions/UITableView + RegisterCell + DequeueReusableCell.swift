//
//  UITableView + Ext.swift
//  WeatherApp
//
//  Created by Arsalan on 02.06.2024.
//

import UIKit

extension UITableView {
    func registerCell(_ cellType: UITableViewCell.Type) {
        let identifier = String(describing: cellType)
        register(cellType, forCellReuseIdentifier: identifier)
    }

    public func dequeue<Cell: UITableViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: type)

        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("❌ Couldn't dequeue cell with identifier: \(identifier) for indexPath: \(indexPath)")
        }

        return cell
    }
}
