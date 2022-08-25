//
//  Rx+ViewLifeCycle.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/21.
//

import UIKit

import RxSwift

extension RxSwift.Reactive where Base: UIViewController {
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewDidDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidDisappear(_:)))
            .map { $0.first as? Bool ?? false }
    }
}
