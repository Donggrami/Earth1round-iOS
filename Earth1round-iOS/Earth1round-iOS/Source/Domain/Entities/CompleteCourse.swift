//
//  CompleteCourse.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation

struct CompleteCourse: Codable {
    let courseID: Int

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
    }
    
}
