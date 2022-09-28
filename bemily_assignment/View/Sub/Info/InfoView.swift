//
//  InfoView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import FirebaseDatabase
import UIKit
import SnapKit

class InfoView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.text = "정보"
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        
        return tableView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
        
    let infoList = [
        "artistName",
        "fileSizeBytes",
        "primaryGenreName",
        "minimumOsVersion",
        "trackContentRating",
        "version"
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

extension InfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        
        let title = infoList[indexPath.row]
        
        let ref: DatabaseReference!
        ref = Database.database().reference(withPath: "results").child("0")
        
        ref.child(title).observeSingleEvent(of: .value) { snapshot, _ in
            guard var info = snapshot.value as? String else { return }
            var key = title
            
            switch title {
            case "artistName":
                key = "제공자"
            case "fileSizeBytes":
                key = "앱 바이트 크기"
                let size = Int(info)! / 1024 / 1024
                info = String(size) + "MB"
            case "primaryGenreName":
                key = "카테고리"
            case "minimumOsVersion":
                key = "최소 지원 iOS 버전"
            case "trackContentRating":
                key = "연령 등급"
            case "version":
                key = "앱 버전"
            default:
                break
            }
            
            cell.setup(key, info)
        }
        
        return cell
    }
}

private extension InfoView {
    func setupViews() {
        [
            titleLabel,
            tableView,
            separatorView
        ].forEach {
            addSubview($0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(300.0)
        }
    }
}
