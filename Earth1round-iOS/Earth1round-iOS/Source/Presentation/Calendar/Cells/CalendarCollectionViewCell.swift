//
//  CalendarCollectionViewCell.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/19.
//

import UIKit

import SnapKit
import Then

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private var dayLabel = UILabel().then {
        $0.font = .erFont(type: .NTRegular20)
        $0.textAlignment = .center
        $0.text = "1"
    }
    
    private var stepCountLabel = UILabel().then {
        $0.font = .erFont(type: .NTRegular12)
        $0.textColor = Asset.Colors.pointBlue.color
        $0.textAlignment = .center
        $0.text = "100"
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setSelectCell() : setUnselectCell()
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubviews(dayLabel, stepCountLabel)
    }
    
    private func setupConstraints() {
        dayLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(contentView.frame.width)
        }
        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(day: String) {
        dayLabel.text = day
        stepCountLabel.isHidden = dayLabel.text == ""
    }
    
    func setupStepCount(step: String) {
        stepCountLabel.text = step
    }
    
    func setSelectCell() {
        dayLabel.backgroundColor = Asset.Colors.pointBlue.color
        dayLabel.textColor = .white
        dayLabel.makeRounded(radius: contentView.frame.width / 2)
    }
    
    func setUnselectCell() {
        dayLabel.backgroundColor = .clear
        dayLabel.textColor = .black
    }
}
