//
//  CalendarViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

import SnapKit
import Then
import HealthKit

final class CalendarViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let stepCountLabel = UILabel().then {
        $0.text = "누적된 걸음 수"
        $0.font = .erFont(type: .NTRegular16)
    }
    var countLabel = UILabel().then {
        $0.text = "20,000"
        $0.font = .erFont(type: .NTBold32)
    }
    private let stepLabel = UILabel().then {
        $0.text = "걸음"
        $0.font = .systemFont(ofSize: 15)
        $0.font = .erFont(type: .NTRegular16)
    }
    private let monthTitleLabel = UILabel().then {
        $0.font = .erFont(type: .NTBold16)
        $0.text = "2022.07"
    }
    private let seperateLine = UIView().then {
        $0.backgroundColor = Asset.Colors.grey20.color
    }
    
    private let previousButton = UIButton().then {
        $0.setImage(Asset.Images.leftArrowButton.image.withRenderingMode(.alwaysTemplate),
                    for: .normal)
        $0.tintColor = Asset.Colors.mainYellow.color
    }
    
    private let nextButton = UIButton().then {
        $0.setImage(Asset.Images.rightArrowButton.image.withRenderingMode(.alwaysTemplate),
                    for: .normal)
        $0.tintColor = Asset.Colors.mainYellow.color
    }
    
    private let weekStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    private let calendarCollectionView = UICollectionView(frame: .zero,
                                                          collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.allowsSelection = false
        $0.register(CalendarCollectionViewCell.self)
    }
    
    private let calendarView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - Properties
    
    private var viewModel = CalendarViewModel()
    private var days: [String] = []
    private var steps: [String] = []
    private var monthTitle = ""
    private var healthStore = HealthStore()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupViewHierarchy()
        setupConstraints()
        setupWeekStackView()
        bind()
    }

    // MARK: - Methods
    
    private func bind() {
        let input = CalendarViewModel.Input(viewWillAppear: rx.viewWillAppear.map { _ in },
                                            previousButtonControlEvent: previousButton.rx.tap.asObservable(),
                                            nextButtonControlEvent: nextButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.monthDays
            .drive(onNext: { days in
                self.days = days
                self.calendarCollectionView.reloadData()
            }).disposed(by: disposeBag)
        
        output.title
            .drive(onNext: { title in
                self.monthTitle = title
                self.monthTitleLabel.text = title
            }).disposed(by: disposeBag)
    }
    
    private func setupWeekStackView() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        dayOfTheWeek.forEach { day in
            let dayLabel = UILabel()
            dayLabel.textAlignment = .center
            dayLabel.text = day
            weekStackView.addArrangedSubview(dayLabel)
        }
    }
    
    private func getSteps(startDate: Date?, endDate: Date?, completion: @escaping (HKStatistics?) -> Void) {
        guard let sampleSteps = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: sampleSteps,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, statistics, _ in
            completion(statistics)
        }
        healthStore.healthStore?.execute(query)
    }
    
    // MARK: - Actions
    
    @objc func calendarButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CalendarViewController {
    
    // MARK: - Default Setting Function
    
    private func initNavigationBar() {
        title = "캘린더"
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(stepCountLabel, countLabel, stepLabel, monthTitleLabel, seperateLine, previousButton, nextButton, weekStackView, calendarCollectionView)
    }
    
    private func setupConstraints() {
        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        countLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(10)
        }
        stepLabel.snp.makeConstraints {
            $0.leading.equalTo(countLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(countLabel)
        }
        monthTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stepLabel.snp.bottom).offset(20)
            $0.height.equalTo(86)
        }
        seperateLine.snp.makeConstraints {
            $0.top.equalTo(monthTitleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        previousButton.snp.makeConstraints {
            $0.centerY.equalTo(monthTitleLabel)
            $0.leading.equalToSuperview().inset(30)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalTo(monthTitleLabel)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(monthTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendarCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let today = dateFormatter.string(from: Date())
        let currentTitle = "\(monthTitle).\(days[indexPath.row])"
        
        today == currentTitle ? cell.setSelectCell() : cell.setUnselectCell()
        cell.configure(day: days[indexPath.row])
        
        dateFormatter.dateFormat = "yyyy.MM"
        guard let monthdate = dateFormatter.date(from: monthTitle) else { return cell }
        
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.string(from: monthdate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let day = days[indexPath.row]
        let startDate = dateFormatter.date(from: "\(date)-\(day) 00:00")
        let endDate = dateFormatter.date(from: "\(date)-\(day) 23:59")
        
        self.getSteps(startDate: startDate, endDate: endDate) { statistics in
            DispatchQueue.main.async {
                if let statistics = statistics?.sumQuantity()?.doubleValue(for: .count()) {
                    
                    cell.setupStepCount(step: "\(Int(statistics))")
                } else {
                    cell.setupStepCount(step: "")
                }
            }
        }
        
        return cell
    }
    
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height / 6 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
