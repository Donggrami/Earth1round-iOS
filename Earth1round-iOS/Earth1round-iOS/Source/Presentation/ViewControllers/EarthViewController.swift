//
//  HomeViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/12.
//

import UIKit
import SnapKit

class EarthViewController: UIViewController{
    
    var hamburgerButton = UIButton().then {
        $0.backgroundColor = .gray
    }
    
    var walkText = UILabel().then {
        $0.text = "2000 걸음"
        $0.font = .boldSystemFont(ofSize: 35)
    }
    
    var dayText = UILabel().then {
        $0.text = "D + day"
    }
    
    var curCourseText = UILabel().then {
        $0.text = "현재 선택한 코스"
    }
    
    var progressText = UILabel().then {
        $0.text = "30%"
    }
    
    var progressBar = UIProgressView().then {
        $0.trackTintColor = .lightGray
        $0.progressTintColor = .gray
        $0.progress = 0.3
    }
    
    var characterView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    
    var homeButton = UIButton().then {
        $0.backgroundColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        initView()
       
        initContraint()
        
        homeButton.addTarget(self, action: #selector(handleTap),for:.touchUpInside)
    }
    
    func initView(){
        self.view.addSubview(hamburgerButton)
        self.view.addSubview(walkText)
        self.view.addSubview(dayText)
        self.view.addSubview(curCourseText)
        self.view.addSubview(progressText)
        self.view.addSubview(progressBar)
        self.view.addSubview(characterView)
        self.view.addSubview(homeButton)
        
    }
    
    func initContraint(){
        hamburgerButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(22)
        }
        
        walkText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(hamburgerButton.snp.bottom).offset(18)
        }
        
        dayText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(walkText.snp.bottom).offset(3)
        }
        
        curCourseText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(dayText.snp.bottom).offset(29)
        }
        
        progressText.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-22)
            make.bottom.equalTo(curCourseText)
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.trailing.equalTo(progressText)
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
            make.trailing.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-45)
        }
    }
    
    @objc func handleTap(){
        let vc=HomeViewController()
       
        navigationController?.pushViewController(vc, animated: true)
    }

}
