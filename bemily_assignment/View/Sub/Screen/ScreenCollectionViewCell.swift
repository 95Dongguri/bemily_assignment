//
//  ScreenCollectionViewCell.swift
//  bemily_assignment
//
//  Created by κΉλν on 2022/09/26.
//

import Kingfisher
import UIKit
import SnapKit

class ScreenCollectionViewCell: UICollectionViewCell {
    static let identifier = "ScreenCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    func setup(_ screen: String) {
        setupLayout()

        let url = URL(string: screen)
        
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: url)
        }
    }
}

private extension ScreenCollectionViewCell {
    func setupLayout() {
        addSubview(imageView)
                
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
