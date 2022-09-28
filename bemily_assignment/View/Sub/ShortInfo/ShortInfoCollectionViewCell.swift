//
//  ShortInfoCollectionViewCell.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/28.
//

import UIKit
import SnapKit

class ShortInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "ShortInfoCollectionViewCell"
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup(_ item: String, _ info: Any) {
        setupLayout()
        
        topLabel.text = item
        bottomLabel.text = "\(info)"
    }
}

private extension ShortInfoCollectionViewCell {
    func setupLayout() {
        [
            topLabel,
            bottomLabel
        ].forEach {
            addSubview($0)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(topLabel)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}
