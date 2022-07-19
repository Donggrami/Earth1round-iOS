//
//  HomeViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/12.
//

import Foundation
import UIKit
import Then

class HomeViewController : UIViewController {
    var hamburgerButton : UIButton = {
        let view=UIButton()
        view.backgroundColor = .gray
        return view
    }()
    
    var totalWalkText : UILabel = {
        let view=UILabel()
        view.text = "누적된 걸음 수"
        return view
    }()
    
    var totalWalk : UILabel = {
        let view=UILabel()
        view.text = "20,000 걸음"
        view.font = .boldSystemFont(ofSize: 35)
        return view
    }()
    

    var characterView : UIView = {
        let view=UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    var characterName : UILabel = {
        let view = UILabel()
        view.text = "이름"
        return view
    }()

    var characterLevel : UILabel = UILabel().then{
        $0.text = " Lv.1"
    }
 
    var chooseCourseButton : UIButton = UIButton().then {
        $0.titleLabel?.text="코스 선택하기"
        $0.backgroundColor = .gray
    }
    
    var homeButton : UIButton = {
        let view=UIButton()
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
        self.view.addSubview(hamburgerButton)
        self.view.addSubview(totalWalkText)
        self.view.addSubview(totalWalk)
        self.view.addSubview(characterView)
        self.view.addSubview(characterName)
        self.view.addSubview(characterLevel)
        self.view.addSubview(chooseCourseButton)
        self.view.addSubview(homeButton)
        
        hamburgerButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(22)
        }
        
        totalWalkText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hamburgerButton.snp.bottom).offset(28)
        }
        
        totalWalk.snp.makeConstraints { make in
            make.centerX.equalTo(totalWalkText)
            make.top.equalTo(totalWalkText.snp.bottom).offset(5)
        }
        
        characterView.snp.makeConstraints{(make) in
            make.width.equalTo(156)
            make.height.equalTo(234)
            make.centerX.equalToSuperview()
            make.top.equalTo(totalWalk.snp.bottom).offset(62)
        }
        
        characterName.snp.makeConstraints { make in
            make.leading.equalTo(characterView.snp.leading)
            make.top.equalTo(characterView.snp.bottom).offset(36)
        }
        
        characterLevel.snp.makeConstraints { make in
            make.trailing.equalTo(characterView.snp.trailing)
            make.bottom.equalTo(characterName.snp.bottom)
        }
        
        
        
        homeButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        chooseCourseButton.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton.snp.leading)
            make.trailing.equalTo(homeButton.snp.trailing)
            make.height.equalTo(75)
            make.top.equalTo(characterName.snp.bottom).offset(19)
        }
        
        homeButton.addTarget(self, action: #selector(handleTap),for: UIControl.Event.touchUpInside)
    }
    
    @objc func handleTap(){
        navigationController?.popViewController(animated: true)
    }
}
