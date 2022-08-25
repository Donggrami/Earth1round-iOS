//
//  MyRecordAPI.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import Moya

enum MyRecordAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<[MyRecord]>
    case getRecord
}

extension MyRecordAPI {
    var path: String {
        switch self {
        case .getRecord:
            return HTTPMethodURL.GET.courseList
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecord:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getRecord:
            return .requestPlain
        }
    }
}
