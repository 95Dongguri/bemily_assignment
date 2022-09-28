//
//  BemilyDetailViewController.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import UIKit
import SnapKit

class BemilyDetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let detailView = DetailView(frame: .zero)
        let shortInfoView = ShortInfoView(frame: .zero)
        let screenView = ScreenView(frame: .zero)
        let descriptionView = DescriptionView(frame: .zero)
        let releaseView = ReleaseView(frame: .zero)
        let infoView = InfoView(frame: .zero)
        
        [
            detailView,
            shortInfoView,
            screenView,
            descriptionView,
            releaseView,
            infoView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
}

private extension BemilyDetailViewController {
    func setupLayout() {
        view.addSubview(scrollView)
                        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

