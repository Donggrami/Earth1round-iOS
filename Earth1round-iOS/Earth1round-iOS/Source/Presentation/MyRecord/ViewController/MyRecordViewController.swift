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
        $0.backgroundColor = Asset.Colors.grey10.color
    }
    
    var viewModel: MyRecordViewModel?
    var records: [MyRecord] = []
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        initNavigationBar()  
        initView()
        initConstraint()
        
        initViewModel()
    }
    
    //MARK - Method
    private func initViewModel() {
        let repository = DefaultMyRecordRepository()
        let useCase = DefaultMyRecordUseCase(repository: repository)
        
        bind(to: DefaultMyRecordViewModel(myRecordUseCase: useCase))
    }
    
    private func bind(to viewModel: DefaultMyRecordViewModel) {
        self.viewModel = viewModel
        let result = viewModel.load()
            .subscribe { [weak self] myrecord in
                self?.initTable(myrecord: myrecord)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }

        print(result)
            
        
    }
    
    private func initTable(myrecord: [MyRecord]) {
        self.records = myrecord
        tableView.reloadData()
    }
    
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
        return records.count
    }
    
    //cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyRecordCell") as? MyRecordCell else{ return .init() }
        
        cell.setData(record: records[indexPath.row])
        cell.backgroundColor = Asset.Colors.grey10.color
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

