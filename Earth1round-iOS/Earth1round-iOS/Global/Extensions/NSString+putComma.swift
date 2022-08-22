//
//  String+putComma.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/21.
//

import Foundation

extension NSString{
    func putComma(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let result = numberFormatter.string(from: NSNumber(value: value)) else { return "0" }
        
        return result
    }
}
