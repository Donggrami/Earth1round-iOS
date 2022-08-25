//
//  CompleteCourseAPI.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import Moya

enum CompleteCourseAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<CompleteCourse>
    case complete
}

extension CompleteCourseAPI {
    var path: String {
        switch self {
        case .complete:
            return HTTPMethodURL.PATCH.course
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .complete:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .complete:
            return .requestPlain
        }
    }
}
