//
//  ShortInfoView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/28.
//

import FirebaseDatabase
import UIKit
import SnapKit

class ShortInfoView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ShortInfoCollectionViewCell.self, forCellWithReuseIdentifier: ShortInfoCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    let shortList = [
        "averageUserRating",
        "contentAdvisoryRating",
        "primaryGenreName",
        "sellerName",
        "currency"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupViews()
    }
}

extension ShortInfoView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shortList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortInfoCollectionViewCell.identifier, for: indexPath) as? ShortInfoCollectionViewCell else { return UICollectionViewCell() }
        
        let short = shortList[indexPath.row]
        
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "results").child("0")
        
        ref.child(short).observeSingleEvent(of: .value) { snapshot, _ in
            guard let info = snapshot.value else { return }
            var key = short
            
            switch short {
            case "averageUserRating":
                key = "평점"
            case "contentAdvisoryRating":
                key = "연령"
            case "primaryGenreName":
                key = "카테고리"
            case "sellerName":
                key = "개발자"
            case "currency":
                key = "언어&통화"
            default:
                break
            }
            
            cell.setup(key, info)
        }
        
        return cell
    }
}

extension ShortInfoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 8.0)
    }
}

private extension ShortInfoView {
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
            $0.bottom.equalToSuperview().inset(8.0)
            $0.height.equalTo(80.0)
        }
    }
}
