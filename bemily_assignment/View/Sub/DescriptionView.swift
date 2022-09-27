//
//  DescriptionView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import FirebaseDatabase
import UIKit
import SnapKit

class DescriptionView: UIView {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 3
        
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
        
        return button
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
        setupViews()
        fetchDescription()
    }
}

private extension DescriptionView {
    func setupViews() {
        [
            descriptionLabel,
            moreButton,
            separatorView
        ].forEach {
            addSubview($0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.leading.bottom.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(moreButton.snp.leading)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16.0)
            $0.width.height.equalTo(50.0)
        }
    }
    
    func fetchDescription() {
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "results").child("0")
        
        ref.child("description").observeSingleEvent(of: .value) { snapshot in
            guard let description = snapshot.value as? String else { return }
            
            DispatchQueue.main.async {
                self.descriptionLabel.text = description
            }
        }
    }
    
    @objc func tapMoreButton() {
        descriptionLabel.numberOfLines = 0
        moreButton.isHidden = true
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.leading.trailing.bottom.equalToSuperview().inset(16.0)
        }
    }
}
