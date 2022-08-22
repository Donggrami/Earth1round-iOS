//
//  Int+withCommas.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/21.
//

import Foundation

extension Int {
    func withCommas() -> String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter.string(from: NSNumber(value: self))!
        }
}
