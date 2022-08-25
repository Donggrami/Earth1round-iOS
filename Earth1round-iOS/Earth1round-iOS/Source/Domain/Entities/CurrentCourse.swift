//
//  Course.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation

struct CurrentCourse: Codable {
    let courseID: Int
    let startPlaceID: Int
    let startPlaceName: String
    let endPlaceID: Int
    let endPlaceName: String
    let distance: Double
    let startDate: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case startPlaceID = "start_place_id"
        case startPlaceName = "start_place_name"
        case endPlaceID = "end_place_id"
        case endPlaceName = "end_place_name"
        case distance = "distance"
        case startDate = "start_date"
    }
    
}
