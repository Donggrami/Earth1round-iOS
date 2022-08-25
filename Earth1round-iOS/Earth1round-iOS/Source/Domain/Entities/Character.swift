//
//  Character.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

struct Character: Codable {
    let customNum: Int
    
    enum CodingKeys: String, CodingKey {
        case customNum = "custom_num"
    }
}
