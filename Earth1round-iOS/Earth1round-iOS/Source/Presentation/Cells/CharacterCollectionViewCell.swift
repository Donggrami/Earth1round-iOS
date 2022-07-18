//
//  CharacterCollectionViewCell.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

import SnapKit
import Then

class CharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        contentView.backgroundColor = .systemGray5
    }
}
