//
//  UIVIew+addSubViews.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
