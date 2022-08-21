//
//  MyRecordCell.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/23.
//

import UIKit
import Then
import SnapKit

class MyRecordCell: UITableViewCell {
    
    private var cellTag = UIView().then {
        $0.backgroundColor = Asset.Colors.mainYellow.color
    }
    
    //MARK - UI
    private var yearTitle = UILabel().then {
        $0.text = "2022"
        $0.font = .erFont(type: .NTRegular16)
        $0.textColor = Asset.Colors.darkGrey.color
    }
    
    private var startDate = UILabel().then {
        $0.text = "May. 01"
        $0.font = .erFont(type: .NTRegular16)
        $0.textColor = Asset.Colors.darkGrey.color
    }
    
    private var fromToText = UILabel().then {
        $0.text = "-"
        $0.font = .erFont(type: .NTRegular16)
        $0.textColor = Asset.Colors.darkGrey.color
    }
    
    private var endDate = UILabel().then {
        $0.text = "May.01"
        $0.font = .erFont(type: .NTRegular16)
        $0.textColor = Asset.Colors.darkGrey.color
    }
    
    private var courseText = UILabel().then {
        $0.text = "코스"
        $0.font = .erFont(type: .NTRegular16)
        $0.textColor = Asset.Colors.darkGrey.color
    }
    
    private var distanceText = UILabel().then {
        $0.text = "거리 Km"
        $0.font = .erFont(type: .NTRegular20)
        $0.textColor = Asset.Colors.pointBlue .color
    }
    
    
    //MARK - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [cellTag,yearTitle,startDate,fromToText,endDate,courseText,distanceText].forEach {
            contentView.addSubview($0)
        }
        
        cellTag.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(13)
        }
        
        yearTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(cellTag.snp.trailing).offset(15)
        }
        
        startDate.snp.makeConstraints{ make in
            make.leading.equalTo(yearTitle)
            make.top.equalTo(yearTitle.snp.bottom).offset(4)
        }
        
        fromToText.snp.makeConstraints { make in
            make.centerY.equalTo(startDate)
            make.leading.equalTo(startDate.snp.trailing).offset(5)
        }
       
        endDate.snp.makeConstraints{ make in
            make.centerY.equalTo(startDate)
            make.leading.equalTo(fromToText.snp.trailing).offset(5)
        }
        
        courseText.snp.makeConstraints { make in
            make.trailing.equalTo(distanceText)
            make.bottom.equalTo(distanceText.snp.top).offset(-2)
        }
                  
        distanceText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-19)
            make.bottom.equalToSuperview().offset(-12)
        }
        
    }
    
    //MARK - Method
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 9, left: 18, bottom: 9, right: 18))
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
