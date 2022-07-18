//
//  CourseViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

import SnapKit
import Then

final class CourseViewController: BaseViewController {
    // MARK: - UI Components
    
    private var mapView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private var exchangeButton = UIButton().then {
        $0.backgroundColor = .lightGray
    }
    
    private var startingPointButton = UIButton().then {
        $0.setTitle("출발지 선택", for: .normal)
        $0.titleLabel?.contentMode = .left
        $0.backgroundColor = .systemGray4
    }
    
    private var destinationButton = UIButton().then {
        $0.setTitle("도착지 선택", for: .normal)
        $0.titleLabel?.contentMode = .left
        $0.backgroundColor = .systemGray4
    }
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigatonBar()
        setupViewHierarchy()
        setupConstraints()
    }
    // MARK: - Methods
    
    private func initNavigatonBar() {
        navigationController?.initBackButtonNavigationBar(backgorundColor: .clear)
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(mapView, exchangeButton, startingPointButton, destinationButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.height.equalTo(500)
            $0.top.leading.trailing.equalToSuperview()
        }
        exchangeButton.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(45)
            $0.width.height.equalTo(50)
            $0.leading.equalToSuperview().inset(20)
        }
        startingPointButton.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.leading.equalTo(exchangeButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(41)
        }
        destinationButton.snp.makeConstraints {
            $0.top.equalTo(startingPointButton.snp.bottom).offset(20)
            $0.leading.equalTo(startingPointButton)
            $0.trailing.equalTo(startingPointButton)
            $0.height.equalTo(startingPointButton)
        }
    }
}
