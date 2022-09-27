//
//  DetailView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import FirebaseDatabase
import Kingfisher
import UIKit
import SnapKit

class DetailView: UIView {
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .label
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 150.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .systemBackground
        
        setupViews()
        fetchLogoImage()
        
        titleLabel.text = """
                    비패밀리 메신저
                    Befamily Messenger
                    """
        subTitleLabel.text = "가까운 사람들끼리 쓰는 메신저"
    }
    
}

private extension DetailView {
    func setupViews() {
        [
            appIconImageView,
            titleLabel,
            subTitleLabel,
            downloadButton,
            shareButton
        ].forEach {
            addSubview($0)
        }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(24.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(60.0)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.height.equalTo(32.0)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
        }
    }
    
    func fetchLogoImage() {
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "results").child("0")
        
        ref.child("artworkUrl100").observeSingleEvent(of: .value) { snapshot, _ in
            guard let artworkUrl = snapshot.value as? String else { return }
            
            let url = URL(string: artworkUrl)
            
            DispatchQueue.main.async {
                self.appIconImageView.kf.setImage(with: url)
            }
        }
    }
}
