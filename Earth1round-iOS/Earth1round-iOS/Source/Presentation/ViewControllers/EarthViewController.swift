//
//  HomeViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/12.
//

import UIKit
import SnapKit
import Then
import HealthKit

class EarthViewController: BaseViewController{
    
    var hamburgerButton = UIButton().then {
        $0.backgroundColor = .gray
    }
    
    var walkText = UILabel().then {
        $0.text = "0 걸음"
        $0.font = .systemFont(ofSize: 16)
        $0.changeTextBold(changeText: "0", boldSize: 32)
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
    
    var healthStore: HealthStore?

    
    //MARK - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()


 
        initView()
        
        initContraint()
    
        homeButton.addTarget(self, action: #selector(handleTap),for:.touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        initHealthKit()
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK - Methods

    func initView(){
        view.addSubviews(hamburgerButton,walkText,dayText,
                         curCourseText,progressText,progressBar,
                         characterView,homeButton)
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
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let steps = Int(count ?? 0)
            
            
            DispatchQueue.main.async {
                
                if(steps == 0){
                    self.showPopUp()
                }
                
                self.walkText.text = "\(steps) 걸음"
                
                self.walkText.changeTextBold(changeText: String(steps), boldSize: 32)
            }
       
        }
    }
    
    
    func initContraint(){
        hamburgerButton.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(20)
        }
        
        walkText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(hamburgerButton.snp.bottom).offset(18)
        }
        
        dayText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(walkText.snp.bottom).offset(3)
        }
        
        progressText.snp.makeConstraints { make in
            let mainWidth = Size.screenWidth
            let position = (Float(mainWidth)-40)*progressBar.progress
            make.leading.equalTo(progressBar).offset(position-17)
            make.bottom.equalTo(progressBar.snp.top).offset(-4)
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(dayText.snp.bottom).offset(43)
            make.height.equalTo(15)
        }
        
        curCourseText.snp.makeConstraints { make in
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(progressBar.snp.bottom).offset(4)
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
    
    private func showPopUp(){
        let vc=HealthKitPopUpViewController()
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc,animated: true,completion: nil)
    }
    
    @objc func handleTap(){
        let vc=HomeViewController()
       
        navigationController?.pushViewController(vc, animated: true)
    }

}
