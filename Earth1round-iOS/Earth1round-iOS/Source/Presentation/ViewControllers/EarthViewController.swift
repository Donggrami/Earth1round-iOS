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
    //배경 뷰
    var universeBackground = UIImageView().then {
        $0.image = Asset.Images.homeBack01.image
    }
    
    var infoBackground = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.makeRoundedEach(cornerRadius: 20, maskedCorners: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner])
    }
    
    var earthBackground = UIImageView().then {
        $0.image = Asset.Images.homeBack02.image
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
       
    }

    //홈 화면 정보 뷰
    var hamburgerButton = UIImageView().then {
        $0.image = Asset.Images.homeButton.image
        $0.isUserInteractionEnabled = true
    }
    
    var walkText = UILabel().then {
        $0.text = "0 걸음"
        $0.font = .erFont(type: .NTRegular16)
        $0.changeTextBold(changeText: "0", type: TextStyles.NTBold32)
    }
    
    var homeMessage = UIView().then {
        $0.backgroundColor = Asset.Colors.pointBlue.color
        $0.makeRounded(radius: 11)
    }
    
    var homeMessageText = UILabel().then {
        $0.text = "?"
        $0.textColor = Asset.Colors.white.color
        $0.font = .erFont(type: .NTBold12)
    }
    
    var homeMsgBox = UIImageView().then {
        $0.image = Asset.Images.homeMsgBox.image
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    var homeMsgBoxText = UILabel().then {
        $0.text = "걸음이 안 뜬다면 '건강 > 걸음 > 데이터 소스 및 접근'에서 데이터 읽기 허용을 다시하세요."
        $0.font = .erFont(type: .NTRegular12)
        $0.numberOfLines = 0
        $0.isHidden = true
    }

    var dayText = UILabel().then {
        $0.text = "D + day"
        $0.font = .erFont(type: .NTRegular20)
    }
    
    var curCourseText = UILabel().then {
        $0.text = "현재 선택한 코스"
        $0.font = .erFont(type: .NTRegular14)
    }
    
    var progressGage = UIImageView().then {
        $0.image = Asset.Images.homePercent.image
    }
    
    var progressText = UILabel().then {
        $0.text = "30%"
        $0.font = .erFont(type: .NTRegular12)
    }
    
    var progressBar = UIProgressView().then {
        $0.trackTintColor = Asset.Colors.grey10.color
        $0.progressTintColor = Asset.Colors.mainYellow.color
        $0.progress = 0.3
        $0.layer.cornerRadius = 7.5
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 7.5
        $0.subviews[1].clipsToBounds = true
    }
    
    //캐릭터 뷰
    var characterView = UIImageView().then {
        $0.image = Asset.Images.cha_01.image
        $0.contentMode = .scaleAspectFit
    }
    
    var homeButton = UIImageView().then {
        $0.image = Asset.Images.goHomeButton.image
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    var healthStore: HealthStore?

    
    //MARK - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        initView()
        initBackground()
        initInfoViews()
        initCharacterViews()
        
        hamburgerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goSetting)))
        
        homeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goHome)))
        
        homeMessage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showInfo)))
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
        view.addSubviews(universeBackground,infoBackground,earthBackground,
                         hamburgerButton,walkText,dayText,
                         curCourseText,progressGage,progressText,progressBar,
                         homeMessage,homeMessageText,homeMsgBox,homeMsgBoxText,
                         characterView,homeButton)
    }
    
    func initHealthKit(){
        healthStore = HealthStore()
        
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
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
                
                let formattedString = steps.withCommas()
                
                self.walkText.text = "\(formattedString) 걸음"
                
                self.walkText.changeTextBold(changeText: formattedString, type: TextStyles.NTBold32)
            }
       
        }
    }
    
    private func initBackground(){
        universeBackground.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        infoBackground.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(curCourseText).offset(10)
        }
        
        earthBackground.snp.makeConstraints { make in
            make.top.equalTo(characterView.snp.centerY).offset(-24)
            make.centerX.equalToSuperview()
  
        }
    }
     
    private func initInfoViews(){
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
        
        homeMessage.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.leading.equalTo(walkText.snp.trailing).offset(11)
            make.bottom.equalTo(walkText).offset(-5)
        }
        
        homeMessageText.snp.makeConstraints { make in
            make.center.equalTo(homeMessage)
        }
        
        homeMsgBox.snp.makeConstraints { make in
            make.width.equalTo(221)
            make.height.equalTo(90)
            make.top.equalTo(homeMessage.snp.bottom).offset(6)
            make.leading.equalTo(homeMessage).offset(-32)
        }
        
        homeMsgBoxText.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(homeMsgBox).inset(16)
        }
  
        progressGage.snp.makeConstraints { make in
            make.width.equalTo(33)
            make.height.equalTo(41)
            let mainWidth = Size.screenWidth
            let position = (Float(mainWidth)-40)*progressBar.progress
            make.leading.equalTo(progressBar).offset(position-17)
            make.bottom.equalTo(progressBar.snp.top).offset(-4)
        }
        
        progressText.snp.makeConstraints { make in
            make.centerX.equalTo(progressGage)
            make.centerY.equalTo(progressGage).offset(-5)
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
    }
    
    private func initCharacterViews(){
        characterView.snp.makeConstraints{(make) in
            make.width.equalTo(185)
            make.height.equalTo(235)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(homeButton.snp.top).offset(-27)
        }
        
        homeButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.trailing.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-45)
        }
    }
    
    @objc func showInfo(){
        if(homeMsgBox.isHidden){
            homeMsgBox.isHidden = false
            homeMsgBoxText.isHidden = false
        }
        else {
            homeMsgBox.isHidden = true
            homeMsgBoxText.isHidden = true
        }
    }
    
    @objc func goHome(){
        print("gohome!")
        let vc=HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goSetting(){
        let vc=SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
