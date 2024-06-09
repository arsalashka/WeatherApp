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
    }
    
    private var navigationBarTitle = ""
    private let webView = WKWebView()
    
    
    
    init(with title: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationBarTitle = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        setupNavigationBar()
        setupWebView()
        loadURL()
    }
    
    //  MARK: - Private Methods
    private func setupNavigationBar() {
        title = navigationBarTitle
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
