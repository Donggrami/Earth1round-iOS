//
//  TermsTableViewCell.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/02.
//

import UIKit

import SnapKit
import Then

final class TermsTableViewCell: UITableViewCell {
    
    enum TermsStyle {
        case allCheck
        case oneCheck
    }
    
    private let checkButton = UIButton().then {
        $0.backgroundColor = .systemGray3
    }
    
    let titleLabel = UILabel()
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private let arrowButton = UIButton().then {
        $0.backgroundColor = .systemGray3
    }
    
    var termsStyle: TermsStyle?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubviews(checkButton, titleLabel, separatorLine, arrowButton)
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        
        separatorLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupView() {
        if termsStyle == .allCheck {
            arrowButton.isHidden = true
        } else {
            separatorLine.isHidden = true
        }
    }
}
