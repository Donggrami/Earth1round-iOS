//
//  Fonts.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/11.
//

import UIKit

enum TextStyles {
    case NTRegular12
    case NTBold16
    case NTRegular16
    case NTRegular20
    case NTBold32
}

extension UIFont {
    
    static func erFont(type: TextStyles) -> UIFont {
        switch type {
        case .NTRegular12:
            return UIFont(name: "NotoSansKR-Regular", size: 12)!
        case .NTBold16:
            return UIFont(name: "NotoSansKR-Bold", size: 16)!
        case .NTRegular16:
            return UIFont(name: "NotoSansKR-Regular", size: 16)!
        case .NTRegular20:
            return UIFont(name: "NotoSansKR-Regular", size: 20)!
        case .NTBold32:
            return UIFont(name: "NotoSansKR-Bold", size: 32)!
        }
    }
    
}
