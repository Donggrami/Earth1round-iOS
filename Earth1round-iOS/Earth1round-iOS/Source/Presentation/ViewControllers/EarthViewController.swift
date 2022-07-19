//
//  HomeViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/12.
//

import Foundation
import UIKit
import SnapKit

class EarthViewController : UIViewController{
    
    var hamburgerButton : UIButton = {
        let view=UIButton()
        view.backgroundColor = .gray
        return view
    }()
    
    var walkText : UILabel = {
        let view=UILabel()
        view.text = "2000 걸음"
        view.font = .boldSystemFont(ofSize: 35)
        return view
    }()
    
    var dayText : UILabel = {
        let view=UILabel()
        view.text = "D + day"
        return view
    }()
    
    var curCourseText : UILabel = {
        let view=UILabel()
        view.text = "현재 선택한 코스"
        return view
    }()
    
    var progressText : UILabel = {
        let view=UILabel()
        view.text = "30%"
        return view
    }()
    
    var progressBar : UIProgressView = {
        let view=UIProgressView()
        view.trackTintColor = .lightGray
        view.progressTintColor = .gray
        view.progress=0.3
        return view
    }()
    
    var characterView : UIView = {
        let view=UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    var homeButton : UIButton = {
        let view=UIButton()
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
       
        self.view.addSubview(hamburgerButton)
        self.view.addSubview(walkText)
        self.view.addSubview(dayText)
        self.view.addSubview(curCourseText)
        self.view.addSubview(progressText)
        self.view.addSubview(progressBar)
        self.view.addSubview(characterView)
        self.view.addSubview(homeButton)
        
        hamburgerButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(22)
        }
        
        walkText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton.snp.leading)
            make.top.equalTo(hamburgerButton.snp.bottom).offset(18)
        }
        
        dayText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton.snp.leading)
            make.top.equalTo(walkText.snp.bottom).offset(3)
        }
        
        curCourseText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton.snp.leading)
            make.top.equalTo(dayText.snp.bottom).offset(29)
        }
        
        progressText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-22)
            make.bottom.equalTo(curCourseText.snp.bottom)
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton.snp.leading)
            make.trailing.equalTo(progressText.snp.trailing)
            make.top.equalTo(curCourseText.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        characterView.snp.makeConstraints{(make) in
            make.width.equalTo(156)
            make.height.equalTo(234)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-184)
        }
        
        
        homeButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        homeButton.addTarget(self, action: #selector(handleTap),for:.touchUpInside)
    }
    
    @objc func handleTap(){
        let vc=HomeViewController()
       
        navigationController?.pushViewController(vc, animated: true)
    }

}
