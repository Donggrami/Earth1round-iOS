//
//  MyRecord.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation

struct MyRecord: Codable {
    let courseID: Int
    let userID: String
    let startPlaceID: Int
    let endPlaceID: Int
    let distance: Double
    let startDate: String
    let endDate: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case userID = "user_id"
        case startPlaceID = "start_place_id"
        case endPlaceID = "end_place_id"
        case distance = "distance"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
