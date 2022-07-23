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
    
    //MARK - UI
    private var yearTitle = UILabel().then {
        $0.text = "2022"
    }
    
    private var startDate = UILabel().then {
        $0.text = "May. 01"
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
        
        [yearTitle,startDate,endDate,courseText,distanceText].forEach {
            contentView.addSubview($0)
        }
        
        yearTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        startDate.snp.makeConstraints{ make in
            make.leading.equalTo(yearTitle)
            make.top.equalTo(yearTitle.snp.bottom).offset(10)
        }
       
                                          
        endDate.snp.makeConstraints{ make in
            make.leading.equalTo(yearTitle)
            make.top.equalTo(startDate.snp.bottom).offset(10)
        }
        
        distanceText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(endDate)
        }
        courseText.snp.makeConstraints { make in
            make.trailing.equalTo(distanceText)
            make.bottom.equalTo(distanceText.snp.top).offset(-10)
        }
                                

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Method
    
}
