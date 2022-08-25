//
//  HomeViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/12.
//

import UIKit
import Then
import HealthKit

class HomeViewController: BaseViewController {
    var hamburgerButton = UIButton().then{
        $0.backgroundColor = .gray
    }
    
    var totalWalkBackground = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    var totalWalkText = UILabel().then {
        $0.text = "누적된 걸음 수"
    }
    
    var totalWalk = UILabel().then {
        $0.text = "20,000 걸음"
        $0.font = .systemFont(ofSize: 14)
    }
    
    var trophyView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    var characterView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    var characterName = UILabel().then {
        $0.text = "이름"
    }

    var characterLevel = UILabel().then{
        $0.text = " Lv.1"
    }
 
    var chooseCourseButton = UIButton().then {
        $0.titleLabel?.text = "코스 선택하기"
        $0.backgroundColor = .gray
    }
    
    var homeButton = UIButton().then {
        $0.backgroundColor = .gray
    }
    
    
    var healthStore: HealthStore?

    var totalSteps = 0
    
    //MARK - LifeCycle
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        initConstraint()
        
        initHealthKit()
        
        initNavigationHandler()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK - Methods
    
    private func initView(){
        view.addSubviews(hamburgerButton, totalWalkBackground, totalWalkText
                         ,totalWalk,trophyView
                         ,characterView,characterName,characterLevel
        ,chooseCourseButton,homeButton)
    }
    
    private func initConstraint(){
        hamburgerButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(22)
        }
        
        totalWalkBackground.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.leading.equalTo(hamburgerButton)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(hamburgerButton.snp.bottom).offset(20)
        }
        
        totalWalkText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalWalkBackground).offset(10)
        }
        
        totalWalk.snp.makeConstraints { make in
            make.centerX.equalTo(totalWalkText)
            make.top.equalTo(totalWalkText.snp.bottom).offset(7)
        }
        
        trophyView.snp.makeConstraints { make in
            make.width.height.equalTo(68)
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(totalWalkBackground.snp.bottom).offset(10)
        }
        
        characterView.snp.makeConstraints{(make) in
            make.width.equalTo(156)
            make.height.equalTo(234)
            make.centerX.equalToSuperview()
            make.top.equalTo(trophyView.snp.bottom).offset(47)
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
    }
    
    func initHealthKit(){
        healthStore = HealthStore()
        
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
                print(success)
                if success {
                    healthStore.calculateSteps { statisticsCollection in
                        if let statisticsCollection = statisticsCollection {
                            self.getSteps(statisticsCollection)
    
                        }
                    }
                }
            }
        }
    }
    
   
    func getSteps(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let steps = Int(count ?? 0)
            
            self.totalSteps += steps

            DispatchQueue.main.async {
                
                self.totalWalk.text = "\(self.totalSteps) 걸음"
                
                self.totalWalk.changeTextBold(changeText: String(self.totalSteps), boldSize: 32)
            }
       
        }
    }
    
    
    //Navigation
    
    @objc func goToEarth(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goToMyRecord(){
        let vc=MyRecordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc  func goToCourseSelect(){
        let vc=CourseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc  func goToChangeCaracter(){
        let vc=CharacterSelectionViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc  func goToCalendar(){
        let vc=CalendarViewController()
        vc.countLabel.text = "\(totalWalk.text?.filter { $0.isNumber } ?? "0")"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func initNavigationHandler(){
        homeButton.addTarget(self, action: #selector(goToEarth), for: .touchUpInside)

        trophyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToMyRecord)))
  
        characterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToChangeCaracter)))
                                           
        chooseCourseButton.addTarget(self, action: #selector(goToCourseSelect), for: .touchUpInside)
        
        totalWalkBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(goToCalendar)))
    }
        
}
