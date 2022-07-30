//
//  CalendarViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

import SnapKit
import Then

final class CalendarViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private var stepCountLabel = UILabel().then {
        $0.text = "누적된 걸음 수"
        $0.font = .systemFont(ofSize: 15)
    }
    private var countLabel = UILabel().then {
        $0.text = "20,000"
        $0.font = .systemFont(ofSize: 20)
    }
    private var stepLabel = UILabel().then {
        $0.text = "걸음"
        $0.font = .systemFont(ofSize: 15)
    }
    private var calendarView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupViewHierarchy()
        setupConstraints()
    }
    
    // MARK: - Default Setting Function
    
    @objc func calendarButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    private func initNavigationBar() {
        title = "캘린더"
    }
    private func setupViewHierarchy() {
        view.addSubviews(stepCountLabel, countLabel, stepLabel, calendarView)
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
        calendarView.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
}
