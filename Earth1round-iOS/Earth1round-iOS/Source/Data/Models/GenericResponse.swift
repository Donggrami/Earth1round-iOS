//
//  GenericResponse.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/16.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: T?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess, code, message, result
    }
    
}
