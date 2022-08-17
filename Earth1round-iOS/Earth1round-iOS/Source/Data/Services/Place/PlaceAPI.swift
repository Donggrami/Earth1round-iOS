//
//  PlaceAPI.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/14.
//

import Foundation

import Moya

enum PlaceAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<[Place]>
    case getPlaces
}

extension PlaceAPI {
    var path: String {
        switch self {
        case .getPlaces:
            return HTTPMethodURL.GET.places
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPlaces:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPlaces:
            return .requestPlain
        }
    }
}
