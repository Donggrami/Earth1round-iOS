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
        $0.backgroundColor = .yellow
    }
    
    //MARK - UI
    private var yearTitle = UILabel().then {
        $0.text = "2022"
    }
    
    private var startDate = UILabel().then {
        $0.text = "May. 01"
    }
    
    private var fromToText = UILabel().then {
        $0.text = "|"
    }
    
    private var endDate = UILabel().then {
        $0.text = "May.01"
    }
    
    private var courseText = UILabel().then {
        $0.text = "코스"
    }
    
    private var distanceText = UILabel().then {
        $0.text = "거리 Km"
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
            make.top.equalTo(startDate.snp.bottom).offset(5)
            make.bottom.equalTo(endDate.snp.top).offset(5)
            make.centerX.equalTo(startDate)
        }
       
        endDate.snp.makeConstraints{ make in
            make.leading.equalTo(yearTitle)
            make.top.equalTo(fromToText.snp.bottom).offset(8)
        }
        
        courseText.snp.makeConstraints { make in
            make.trailing.equalTo(distanceText)
            make.bottom.equalTo(distanceText.snp.top).offset(-2)
        }
                  
        distanceText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-19)
            make.bottom.equalTo(endDate)
        }
        

    }
    
   
    
    //MARK - Method
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 9, left: 18, bottom: 9, right: 18))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
