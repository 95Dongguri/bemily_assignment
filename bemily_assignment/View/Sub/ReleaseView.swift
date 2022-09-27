//
//  ReleaseView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import FirebaseDatabase
import UIKit
import SnapKit

class ReleaseView: UIView {
    private lazy var newLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        
        return label
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 2
        
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
        fetchRelease()
        
        newLabel.text = "새로운 기능"
    }
}

private extension ReleaseView {
    func setupViews() {
        [
            newLabel,
            versionLabel,
            releaseLabel,
            moreButton,
            separatorView
        ].forEach {
            addSubview($0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        newLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(newLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(newLabel)
        }
        
        releaseLabel.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(24.0)
            $0.leading.bottom.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(moreButton.snp.leading)
        }
        
        moreButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16.0)
            $0.width.height.equalTo(50.0)
        }
    }
    
    func fetchRelease() {
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "results").child("0")
        
        ref.child("releaseNotes").observeSingleEvent(of: .value) { snapshot in
            guard let release = snapshot.value as? String else { return }
            
            DispatchQueue.main.async {
                self.releaseLabel.text = release
            }
        }
        
        ref.child("version").observeSingleEvent(of: .value) { snapshot in
            guard let version = snapshot.value as? String else { return }
            
            DispatchQueue.main.async {
                self.versionLabel.text = "버전 \(version)"
            }
        }
    }
    
    @objc func tapMoreButton() {
        releaseLabel.numberOfLines = 0
        moreButton.isHidden = true
        
        releaseLabel.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(24.0)
            $0.leading.trailing.bottom.equalToSuperview().inset(16.0)
        }
    }
}
