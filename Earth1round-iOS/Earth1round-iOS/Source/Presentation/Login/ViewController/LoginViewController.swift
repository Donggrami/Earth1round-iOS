//
//  LoginViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/26.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let loginImage = UIImageView().then {
        $0.image = UIImage(named: "")
        $0.backgroundColor = .systemGray5
    }
    
    private let loginButtonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 10
        $0.axis = .vertical
    }
    
    private let appleLoginButton = UIButton().then {
        $0.backgroundColor = .systemGray3
        $0.setTitle("애플 로그인", for: .normal)
    }
    
    private let kakaoLoginButton = UIButton().then {
        $0.backgroundColor = .systemYellow
        $0.setTitle("카카오 로그인", for: .normal)
    }
    
    private let nonLoginButton = UIButton()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
    }
    
    // MARK: - Default Setting Function
    
    private func setupViewHierarchy() {
        view.addSubviews(loginImage, loginButtonStackView)
        loginButtonStackView.addArrangedSubviews([appleLoginButton, kakaoLoginButton])
    }
    
    private func setupConstraints() {
        loginImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(300)
        }
        
        loginButtonStackView.snp.makeConstraints {
            $0.top.equalTo(loginImage.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(100)
        }
    }
}
