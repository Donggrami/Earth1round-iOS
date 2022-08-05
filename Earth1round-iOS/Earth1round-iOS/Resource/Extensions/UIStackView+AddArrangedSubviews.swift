//
//  UIStackView+AddArrangedSubviews.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/30.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ view: [UIView]) {
        view.forEach { self.addArrangedSubview($0) }
    }
}
