//
//  WebViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 11.05.2024.
//

import UIKit
import WebKit
import SnapKit

final class WebViewController: UIViewController {
    
    private enum Constants: String {
        case urlString = "https://meteoinfo.ru/t-scale"
        case navigationBarTitle = "Info"
    }
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        setupNavigationBar()
        setupWebView()
        loadURL()
    }
    
    //  MARK: - Private Methods
    private func setupNavigationBar() {
        title = Constants.navigationBarTitle.rawValue
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemSymbol: .xCircleFill)?
                .applyingSymbolConfiguration(.init(hierarchicalColor: .white))?
                .applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 20))),
            style: .plain,
            target: self,
            action: #selector(closeButtonPressed)
        )
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadURL() {
        if let url = URL(string: Constants.urlString.rawValue) {
            webView.load(URLRequest(url: url))
        }
    }
    
//    MARK: - @objc Methods
    @IBAction private func closeButtonPressed() {
        navigationItem.hidesBackButton = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.popViewController(animated: true)
    }
}
