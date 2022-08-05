//
//  NicknameViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/01.
//

import UIKit

import SnapKit
import Then

class NicknameViewController: BaseViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "함께 걸을 동그라미의\n이름을 지어주세요"
        $0.numberOfLines = 0
    }
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "이름을 입력해주세요"
        $0.backgroundColor = .systemGray6
        $0.addLeftPadding()
    }
    
    private let startButton = UIButton().then {
        $0.backgroundColor = .systemGray6
        $0.setTitle("시작하기", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(titleLabel, nicknameTextField, startButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}
