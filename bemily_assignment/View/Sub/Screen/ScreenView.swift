//
//  ScreenView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import FirebaseDatabase
import UIKit
import SnapKit

class ScreenView: UIView {
    var screenList: [String] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
//        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ScreenCollectionViewCell.self, forCellWithReuseIdentifier: ScreenCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        fetchScreenUrl()
        setupViews()
    }
}

extension ScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenCollectionViewCell.identifier, for: indexPath) as? ScreenCollectionViewCell else { return UICollectionViewCell() }
        
        let screen = screenList[indexPath.row]
        cell.setup(screen)
        
        return cell
    }
}

extension ScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 8.0)
    }
}

private extension ScreenView {
    func setupViews() {
        [
            collectionView,
            separatorView
        ].forEach {
            addSubview($0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
        }
    }
    
    func fetchScreenUrl() {
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "results").child("0")
        
        ref.child("screenshotUrls").observeSingleEvent(of: .value) { snapshot, _  in
            guard let screenList = snapshot.value as? [String] else { return }
            
            self.screenList = screenList
            self.collectionView.reloadData()
        }
    }
}
