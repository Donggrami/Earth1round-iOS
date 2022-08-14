//
//  HealthKitPopUpViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/10.
//

import Foundation
import UIKit

class HealthKitPopUpViewController: UIViewController{
    
    //MARK - Attributes

    var popUpView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var infoText = UILabel().then {
        $0.text = "아이폰의 '건강 > 걸음 > 데이터 소스 및 접근'에서\n 데이터 읽기 허용을 눌러주세요"
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    var acceptButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setTitle("확인", for: .normal)
    }
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
            
        initView()
        
        initConstranit()
    }
    
    
    //MARK - Methods
    private func initView(){
    
        self.view.backgroundColor = UIColor(white : 0, alpha: 0.5)
 
        self.view.addSubviews(popUpView,infoText,acceptButton)
        
        acceptButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
    }
    
    private func initConstranit(){
        popUpView.snp.makeConstraints { make in
            make.leading.equalTo(infoText).offset(-20)
            make.top.equalTo(infoText).offset(-30)
            make.trailing.equalTo(infoText).offset(20)
            make.bottom.equalTo(infoText).offset(90)
            
            make.center.equalToSuperview()
        }
        
        infoText.snp.makeConstraints { make in
            make.center.equalTo(popUpView)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(popUpView)
            make.height.equalTo(40)
        }
    }
    
    @objc func dismiss(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
