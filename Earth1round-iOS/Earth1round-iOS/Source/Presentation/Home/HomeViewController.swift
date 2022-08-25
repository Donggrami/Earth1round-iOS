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
    
    //MARK - Views
    var backgroundView = UIImageView().then {
        $0.image = Asset.Images.chaHomeBack.image
    }
    
    var hamburgerButton = UIImageView().then{
        $0.image = Asset.Images.homeButton.image
        $0.isUserInteractionEnabled = true
    }
    
    var totalWalkBackground = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.makeRoundedWithBorder(radius: 10,
                                 color: Asset.Colors.mainYellow.color.cgColor, borderWith: 2)
    }
    
    var totalWalkText = UILabel().then {
        $0.text = "누적된 걸음 수"
        $0.font = .erFont(type: .NTRegular16)
        $0.textColor = Asset.Colors.darkGrey.color
    }
    
    var totalWalk = UILabel().then {
        $0.text = "20,000 걸음"
        $0.font = .erFont(type: .NTRegular14)
    }
    
    var calendarButton = UIImageView().then {
        $0.image = Asset.Images.rightArrowButton.image
        $0.image = $0.image?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = Asset.Colors.mainYellow.color
    }
    
    var trophyView = UIImageView().then {
        $0.image = Asset.Images.chaHomeBadge.image
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
    }
    
    var characterView = UIImageView().then {
        $0.image = Asset.Images.cha01.image
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
    }
    
    var characterName = UILabel().then {
        $0.text = "동그라미"
        $0.font = .erFont(type: .NTRegular20)
    }

    var characterNameBackground = UIView().then{
        $0.backgroundColor = Asset.Colors.white.color
        $0.makeRounded(radius: 26.5)
        
    }
 
    var chooseCourseButton = UIImageView().then {
        $0.image = Asset.Images.chaHomeNavi.image
        $0.isUserInteractionEnabled = true
    }
    
    var homeButton = UIImageView().then {
        $0.image = Asset.Images.chaHomeEarth.image
        $0.isUserInteractionEnabled = true
    }
    
    var courseStartDate: Date?
    var healthStore: HealthStore?

    var viewModel: DefaultHomeViewModel?
    var totalSteps = 0
    
    private let characters: [UIImage] = [Asset.Images.cha01.image, Asset.Images.cha02.image, Asset.Images.cha03.image, Asset.Images.cha04.image, Asset.Images.cha05.image, Asset.Images.cha06.image, Asset.Images.cha07.image]
    
    //MARK - LifeCycle
   
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initConstraint()
        initViewModel()
        initHealthKit()
        initNavigationHandler()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK - Methods
    private func initViewModel() {
        let repository = DefaultHomeRepository()
        let useCase = DefaultHomeUseCase(repository: repository)
        
        bind(to: DefaultHomeViewModel(homeUseCase: useCase))
    }
    
    private func bind(to viewModel: DefaultHomeViewModel) {
        self.viewModel = viewModel
        let result = viewModel.load()
            .subscribe { [weak self] homeUser in
                self?.initUser(homeUser: homeUser)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }

        print(result)
            
        let output = viewModel.loadCharacter(input: rx.viewWillAppear.map { _ in })
            
        output.drive(onNext: { number in
                self.characterView.image = self.characters[number]
            }).disposed(by: disposeBag)
        
    }
    
    private func initUser(homeUser: HomeUser) {
        let name = homeUser.nickname ?? "동그라미"
        self.characterName.text = name
    }
    
    private func initHealthKit(){
        healthStore = HealthStore()
        
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
                print(success)
                if success {
                    healthStore.calculateSteps(startDate: self.courseStartDate ?? Date()) { statisticsCollection in
                        if let statisticsCollection = statisticsCollection {
                            self.getSteps(statisticsCollection)
    
                        }
                    }
                }
            }
        }
    }
    
   
    private func getSteps(_ statisticsCollection: HKStatisticsCollection) {
    
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: self.courseStartDate ?? Date(), to: endDate) { statistics, stop in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let steps = Int(count ?? 0)
            
            self.totalSteps += steps

            DispatchQueue.main.async {

                let formattedString = self.totalSteps.withCommas()
                self.totalWalk.text = "\(formattedString) 걸음"
                
                self.totalWalk.changeTextBold(changeText: formattedString, type: TextStyles.NTBold32)
            }
       
        }
    }
    
    //초기화
    private func initView(){
        view.addSubviews(backgroundView,hamburgerButton, totalWalkBackground, totalWalkText,totalWalk,calendarButton, trophyView,characterView,characterNameBackground,characterName,
        chooseCourseButton,homeButton)
    }
    
    private func initConstraint(){
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hamburgerButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(22)
        }
        
        totalWalkBackground.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.leading.equalTo(hamburgerButton)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(hamburgerButton.snp.bottom).offset(30)
        }
        
        totalWalkText.snp.makeConstraints { make in
            make.leading.equalTo(totalWalkBackground).offset(16)
            make.top.equalTo(totalWalkBackground).offset(13)
        }
        
        totalWalk.snp.makeConstraints { make in
            make.leading.equalTo(totalWalkText)
            make.top.equalTo(totalWalkText.snp.bottom)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(20)
            make.centerY.equalTo(totalWalkBackground)
            make.trailing.equalTo(totalWalkBackground).offset(-18)
        }
        
        trophyView.snp.makeConstraints { make in
            make.width.height.equalTo(68)
            make.leading.equalTo(hamburgerButton)
            make.top.equalTo(totalWalkBackground.snp.bottom).offset(24)
        }
        
        characterView.snp.makeConstraints{(make) in
            make.width.equalTo(173)
            make.height.equalTo(160)
            make.centerX.equalToSuperview()
            make.top.equalTo(trophyView.snp.bottom).offset(20)
        }
        
        characterNameBackground.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(234)
            make.centerX.equalTo(characterView)
            make.top.equalTo(characterView.snp.bottom).offset(48)
        }
        
        characterName.snp.makeConstraints { make in
            make.center.equalTo(characterNameBackground)
        }
        
        homeButton.snp.makeConstraints { make in
            make.width.height.equalTo(108)
            make.trailing.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-48)
        }
        
        chooseCourseButton.snp.makeConstraints { make in
            make.width.height.equalTo(108)
            make.centerY.equalTo(homeButton)
            make.trailing.equalTo(homeButton.snp.leading).offset(-19)
        }
    }
    
    //MARK - Navigation
    @objc func goToSetting(){
        let vc=SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
        hamburgerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSetting)))

        homeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToEarth)))

        trophyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToMyRecord)))
  
        characterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToChangeCaracter)))
                                           
        chooseCourseButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToCourseSelect)))
        
        totalWalkBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToCalendar)))
    }
  
        
}


