//
//  TermsViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/01.
//

import UIKit

import SnapKit
import Then

final class TermsViewController: BaseViewController {
    
    // MARK: - UI Components

    private let titleLabel = UILabel().then {
        $0.text = "약관 동의"
    }
    
    private let termsTableView = UITableView().then {
        $0.register(TermsTableViewCell.self)
        $0.separatorStyle = .none
        $0.bounces = false
    }
    
    // MARK: - Properties
    
    private let termsTitle = ["약관 전체 동의", "(필수)서비스 이용 약관", "(필수)개인정보 처리 방침", "(필수)위치기반 서비스"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
        setDelegation()
    }
    
    // MARK: - Defalut Setting Function
    
    private func setupViewHierarchy() {
        view.addSubviews(titleLabel, termsTableView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        termsTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(30)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setDelegation() {
        termsTableView.delegate = self
        termsTableView.dataSource = self
    }
}

// MARK: - Extensions

extension TermsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return termsTitle.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TermsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if indexPath.row == 0 {
            cell.termsStyle = .allCheck
            cell.setupConstraints()
        } else {
            cell.termsStyle = .oneCheck
            cell.setupConstraints()
        }
        cell.setupView()
        cell.titleLabel.text = termsTitle[indexPath.row]
        return cell
    }
}

extension TermsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
