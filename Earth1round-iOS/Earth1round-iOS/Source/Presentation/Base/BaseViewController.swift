//
//  BaseViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/18.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    private func render() {
        view.backgroundColor = .white
    }
}
