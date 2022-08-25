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
    
    private var characterImage = UIImageView()
    
    // MARK: - Properties
    
    let characters: [UIImage] = [Asset.Images.cha01.image, Asset.Images.cha02.image, Asset.Images.cha03.image, Asset.Images.cha04.image, Asset.Images.cha05.image, Asset.Images.cha06.image,Asset.Images.cha07.image]

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        contentView.backgroundColor = .white
        contentView.makeRounded(radius: 10)
        contentView.addSubview(characterImage)
    }
    
    private func setupConstraints() {
        characterImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(image: UIImage) {
        characterImage.image = image
    }
    
}
