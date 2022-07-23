//
//  HomeViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/12.
//

import UIKit
import Then

class HomeViewController: UIViewController {
    var hamburgerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .gray
        return view
    }()
    
    var totalWalkText: UILabel = {
        let view = UILabel()
        view.text = "누적된 걸음 수"
        return view
    }()
    
    var totalWalk: UILabel = {
        let view = UILabel()
        view.text = "20,000 걸음"
        view.font = .boldSystemFont(ofSize: 35)
        return view
    }()
    

    var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    var characterName: UILabel = {
        let view = UILabel()
        view.text = "이름"
        return view
    }()

    var characterLevel: UILabel = UILabel().then{
        $0.text = " Lv.1"
    }
 
    var chooseCourseButton: UIButton = UIButton().then {
        $0.titleLabel?.text = "코스 선택하기"
        $0.backgroundColor = .gray
    }
    
    var homeButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .gray
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        initView()
        
        hamburgerButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
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
            make.leading.equalTo(characterView)
            make.top.equalTo(characterView.snp.bottom).offset(36)
        }
        
        characterLevel.snp.makeConstraints { make in
            make.trailing.equalTo(characterView)
            make.bottom.equalTo(characterName)
        }
        
        homeButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.trailing.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-45)
        }
        
        chooseCourseButton.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.trailing.equalTo(homeButton)
            make.height.equalTo(75)
            make.top.equalTo(characterName.snp.bottom).offset(19)
        }
        
        homeButton.addTarget(self, action: #selector(handleTap),for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func initView(){
        self.view.addSubview(hamburgerButton)
        self.view.addSubview(totalWalkText)
        self.view.addSubview(totalWalk)
        self.view.addSubview(characterView)
        self.view.addSubview(characterName)
        self.view.addSubview(characterLevel)
        self.view.addSubview(chooseCourseButton)
        self.view.addSubview(homeButton)
    }
    
    @objc func handleTap(){
        navigationController?.popViewController(animated: true)
    }
}
