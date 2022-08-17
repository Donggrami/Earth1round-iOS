//
//  UIView+makeRounded.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/06.
//

import UIKit

extension UIView {
    func makeRounded(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func makeRoundedWithBorder(radius: CGFloat, color: CGColor, borderWith: CGFloat = 1) {
        makeRounded(radius: radius)
        self.layer.borderWidth = borderWith
        self.layer.borderColor = color
    }
}
