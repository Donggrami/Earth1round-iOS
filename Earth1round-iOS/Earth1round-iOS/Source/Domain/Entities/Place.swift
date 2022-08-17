//
//  Place.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/14.
//

import Foundation

struct Place: Codable {
    let placeID: Int
    let placeName: String
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case placeName = "place_name"
        case latitude, longitude
    }
}
