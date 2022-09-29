//
//  InfoTableViewCell.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/28.
//

import UIKit
import SnapKit

class InfoTableViewCell: UITableViewCell {
    static let identifier = "InfoTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    func setup(_ title: String, _ info: String) {
        setupLayout()
        
        titleLabel.text = title
        infoLabel.text = info
    }
}

private extension InfoTableViewCell {
    func setupLayout() {
        selectionStyle = .none
        
        [
            titleLabel,
            infoLabel
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(titleLabel)
        }
    }
}
