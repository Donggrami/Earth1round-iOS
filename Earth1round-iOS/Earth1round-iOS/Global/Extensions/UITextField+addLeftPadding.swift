//
//  UITextField+addLeftPadding.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/02.
//

import UIKit.UITextField

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
