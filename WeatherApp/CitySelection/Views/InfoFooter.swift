//
//  InfoFooter.swift
//  WeatherApp
//
//  Created by Arsalan on 06.06.2024.
//

import UIKit
import SnapKit

final class InfoFooter: UICollectionReusableView {
    //  MARK: - Properties
    private let infoTextView = UITextView()
    
    var linkAction: ((URL) -> Void)?
    
    //  MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInfoTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods
    func setup(_ infoAttributedString: NSAttributedString?) {
        infoTextView.attributedText = infoAttributedString
    }
    
    //  MARK: - Private Methods
    private func setupInfoTextView() {
        addSubview(infoTextView)
        infoTextView.font = .systemFont(ofSize: 13, weight: .medium)
        infoTextView.isEditable = false
        infoTextView.isScrollEnabled = false
        infoTextView.textContainerInset = .zero
        infoTextView.linkTextAttributes = [.foregroundColor: UIColor.gray,
                                           .underlineStyle: NSUnderlineStyle.single.rawValue]
        infoTextView.backgroundColor = .clear
        infoTextView.delegate = self
        
        infoTextView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

extension InfoFooter: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange) -> Bool {
        linkAction?(URL)
    
        return false
    }
}
