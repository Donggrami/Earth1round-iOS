//
//  UILabel+changeTextBold.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/06.
//

import UIKit

extension UILabel {
    func changeTextBold(changeText: String, type: TextStyles ) {
        
        guard let text = self.text else { return }
        
        let font = UIFont.erFont(type: type)
        
        let attributeString = NSMutableAttributedString(string: text)
        
        // changeText만 bold로 변경
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: changeText))
        
        self.attributedText = attributeString
    }
    
    func changeTextColor(changeText: String, type: TextStyles, color: CGColor ) {
        
        guard let text = self.text else { return }
        
        let font = UIFont.erFont(type: type)
        
        let attributeString = NSMutableAttributedString(string: text)
        
        // changeText만 bold로 변경
        attributeString.addAttribute(.font, value: font,
                                     range: (text as NSString).range(of: changeText))
        attributeString.addAttribute(.foregroundColor, value: color,
                                     range: (text as NSString).range(of: changeText))
        
        self.attributedText = attributeString
    }
}


