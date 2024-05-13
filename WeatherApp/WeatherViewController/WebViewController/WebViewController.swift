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
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
    }
    
    //  MARK: - Public Methods
    func open(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    //  MARK: - Private Methods
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
