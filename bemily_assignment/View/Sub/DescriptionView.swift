//
//  DescriptionView.swift
//  bemily_assignment
//
//  Created by 김동혁 on 2022/09/26.
//

import UIKit
import SnapKit

class DescriptionView: UIView {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupViews()
        
        descriptionLabel.text = """
                        비패밀리 메신저 Befamily Messenger",
                        "description":"안녕하세요, 비패밀리팀입니다.\n \n딱 시원해진 화면크기와 편안해진 사용성은 기본!\n비패밀리가 좋은 단 몇 가지 이유를 만나보세요.\n\n# 내가 만드는 이모티콘, 스마일미\n나만의 개성을 담은 스마일미로 감정을 표현해 보세요. 다양한 꾸미기 스티커와 필터로 하나뿐인 이모티콘을 만들 수 있습니다.\n \n# 톡 하고 싶은 친구만 초대하기\n폰 주소록에서 꼭 대화하고 싶은 사람들만 선택해 친구를 맺을 수 있습니다.\n \n# 친구 마다 다른 멀티 프로필\n그룹별로 내 프로필을 다르게 설정하면 프라이버시를 지킬 수 있습니다.\n그룹은 가족, 친구, 지인 등 최대 10개까지 등록할 수 있습니다.\n \n# 기록이 남지 않는 메시지 삭제\n내가 보낸 메시지는 친구화면에서도 언제든지 삭제할 수 있습니다.\n메시지 자동 삭제 타이머는 설정시간 후 사라지고, 스크린 캡쳐도 제한됩니다.\n \n# 유출 걱정 없는 공유OFF\n사진/동영상 전송 다운로드하지 못하게 공유OFF모드로 보낼 수 있습니다.\n공유OFF로 전송된 파일은 상대방이 다운로드, 전달, 공유를 할 수 없습니다.\n \n# 입력한 그대로 써지는 버블티콘\n특허출원 된 버블티콘은 마치 웹툰처럼 이모티콘에 스토리를 만들 수 있습니다.\n사용자가 입력한 대화가 이모티콘에 더해져 더 재미있게 대화를 할 수 있습니다.\n \n# 대화의 감성을 담은 테마설정\n사용자 취향과 대화분위기에 맞도록 대화방 테마를 설정할 수 있습니다.\n시원한, 편안한, 러블리한, 신비한, 시크릿한 대화방 분위기를 연출할 수 있습니다.\n \n# 원하는 대로 메시지 크기조절\n딱 시원한 크기로 사용할 수 있게 대화방에서 바로 메시지 크기를 조절할 수 있습니다.\n메시지를 두 손가락으로 확대/축소하면 원하는 대로 설정할 수 있습니다.\n \n[접근권한안내]\n앱에서 사용하는 접근 권한에 대하여 아래와 같이 안내해 드립니다.\n선택적 접근 권한의 경우 허용에 동의하지 않으실 수 있습니다.\n \n[선택적 접근 권한]\nㆍ카메라\n사진찍기 및 동영상 녹화 권한으로 프로필/대화방 배경설정, 사진/동영상을 전송하기 위해\n사용합니다.\n \nㆍ사진\n앨범 액세스 권한으로 프로필/대화방 배경설정, 사진/동영상을 전송하기 위해 사용합니다.\n \nㆍ연락처(주소록)\n주소록 액세스 권한으로 친구목록을 구성하고 저장하기 위해 사용합니다.\n \nㆍ마이크\n오디오 녹음 권한으로 음성 메시지를 전송하기 위해 사용합니다.\n \nㆍ알림\n알림 이용 권한으로 알림 서비스를 이용하기 위해 사용합니다.\n \nㆍ위치\n이 기기의 위치에 액세스하기 권한으로 내 위치정보를 확인하고 전송하기 위해 사용합니다.\n기존 설치된 앱을 사용하시는 경우에는 앱을 삭제 후 재설치 하셔야 접근 권한 설정이 가능합니다.\n \n[이용문의]\n비패밀리에 궁금하신 사항은 비패밀리앱에 도움말 또는 contact@bemily.com 으로 문의 주시기 바랍니다.\n \n감사합니다.
                        """
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
            $0.top.trailing.equalToSuperview().inset(32.0)
            $0.width.height.equalTo(50.0)
        }
    }
    
    @objc func tapMoreButton() {
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.leading.trailing.bottom.equalToSuperview().inset(16.0)
        }
    }
}
