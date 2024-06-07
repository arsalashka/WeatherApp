//
//  TestViewController.swift
//  WeatherApp
//
//  Created by Arsalan on 03.06.2024.
//

import UIKit
import SnapKit

class BackgroundView: UICollectionReusableView {
    static let id = String(describing: BackgroundView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray.withAlphaComponent(0.5)
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SectionHeader: UICollectionReusableView {
    static let id = String(describing: SectionHeader.self)
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(with title: String) {
        titleLabel.text = title
    }
}

class SectionFooter: UICollectionReusableView {
    static let id = String(describing: SectionFooter.self)
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.textColor = .black.withAlphaComponent(0.6)
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(with title: String) {
        titleLabel.text = title
    }
}

typealias Section = CityWeatherViewModel.Section
typealias Item = CityWeatherViewModel.Item

class TestViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    
    
    
//    var viewModel: TableViewModelInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.dataSource = self
    
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.id)
        collectionView.register(SectionFooter.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: SectionFooter.id)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [self]   sectionIndex, _ in
            
            if sectionIndex == 0 {
                return createLayoutForFirstSection()
            } else {
                return createLayoutForSecondSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        layout.register(BackgroundView.self, forDecorationViewOfKind: BackgroundView.id)
        
        return layout
    }
    
    private func createLayoutForFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets.trailing = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(100))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let layoutSectionHearerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                                  elementKind: UICollectionView.elementKindSectionHeader,
                                                                                  alignment: .top)
        layoutSectionHearerItem.pinToVisibleBounds = true
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 35, bottom: 15, trailing: 35)
        layoutSection.boundarySupplementaryItems = [layoutSectionHearerItem]
        
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: BackgroundView.id)
        decorationItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        layoutSection.decorationItems = [decorationItem]
        
        return layoutSection
    }
    
    private func createLayoutForSecondSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets.bottom = 1
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let layoutSectionHearerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                                  elementKind: UICollectionView.elementKindSectionHeader,
                                                                                  alignment: .top)
        layoutSectionHearerItem.pinToVisibleBounds = true
        
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let layoutSectionFooterItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionFooterSize,
                                                                                  elementKind: UICollectionView.elementKindSectionFooter,
                                                                                  alignment: .bottom)

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 35)
        layoutSection.boundarySupplementaryItems = [layoutSectionHearerItem, layoutSectionFooterItem]


        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: BackgroundView.id)
        decorationItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        layoutSection.decorationItems = [decorationItem]
        
        return layoutSection
    }
}

extension TestViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .blue.withAlphaComponent(0.7)
        } else {
            cell.backgroundColor = .red.withAlphaComponent(0.7)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeader.id,
                for: indexPath
            ) as? SectionHeader else { return UICollectionReusableView() }
            
            sectionHeader.setupTitle(with: "Header")
            
            return sectionHeader
            
        default:
            guard let sectionFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionFooter.id,
                for: indexPath
            ) as? SectionFooter else { return UICollectionReusableView() }
            
            sectionFooter.setupTitle(with: "Footer")
            
            return sectionFooter
        }
    }
}
