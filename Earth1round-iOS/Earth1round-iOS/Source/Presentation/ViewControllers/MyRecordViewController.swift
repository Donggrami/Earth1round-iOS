//
//  MyRecordViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/23.
//

import SnapKit
import UIKit
import Then

class MyRecordViewController: BaseViewController{
    
    //MARK - UI
    private var tableView  = UITableView().then {
        $0.register(MyRecordCell.self, forCellReuseIdentifier: "MyRecordCell")
        $0.backgroundColor = .lightGray
    }
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        tableView.delegate = self
        tableView.dataSource = self
        
        initNavigationBar()
        
        initView()
        
        initConstraint()
    }
    

    
    //MARK - Method
    private func initNavigationBar(){
        navigationController?.initBackButtonNavigationBar()
        title = "나의 기록"
    }
    
    private func initView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
    }
    
    private func initConstraint(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MyRecordViewController: UITableViewDataSource, UITableViewDelegate {
    //테이블 요소 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyRecordCell") as? MyRecordCell else{ return .init() }
        
        cell.backgroundColor = .lightGray
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(126)
    }
    
    
}

