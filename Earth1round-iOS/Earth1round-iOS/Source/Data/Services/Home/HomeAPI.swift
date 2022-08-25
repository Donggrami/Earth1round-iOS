//
//  HomeAPI.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import Moya

enum HomeAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<HomeUser>
    case getUser
}

extension HomeAPI {
    var path: String {
        switch self {
        case .getUser:
            return HTTPMethodURL.GET.myCharater
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        }
    }
}
