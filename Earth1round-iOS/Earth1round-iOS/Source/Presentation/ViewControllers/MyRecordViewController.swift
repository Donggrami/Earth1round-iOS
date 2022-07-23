//
//  MyRecordViewController.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/23.
//

import SnapKit
import UIKit
import Then

class MyRecordViewController: UIViewController{
    
    //MARK - UI
    private var tableView  = UITableView().then {
        $0.register(MyRecordCell.self, forCellReuseIdentifier: "MyRecordCell")
    }
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        tableView.delegate = self
        tableView.dataSource = self
        
        initNavigationBar()
        initView()
        initConstraint()
    }
    

    
    //MARK - Method
    private func initNavigationBar(){
        navigationController?.title = "나의 기록"
    }
    
    private func initView(){
        view.addSubview(tableView)
    }
    
    private func initConstraint(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
   
    
}

