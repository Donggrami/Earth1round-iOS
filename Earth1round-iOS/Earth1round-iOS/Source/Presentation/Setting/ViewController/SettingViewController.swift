//
//  SettingViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/26.
//

import UIKit

import SnapKit
import Then

class SettingViewController: UIViewController {
    private let profileImage = UIImageView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "동그라미"
    }
    
    private let seperateLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private let leaveButton = UIButton().then {
        $0.backgroundColor = .systemGray3
        $0.setTitle("회원 탈퇴하기", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
