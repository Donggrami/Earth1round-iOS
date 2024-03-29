//
//  CourseAPI.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import Moya

enum CurrentCourseAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<CurrentCourse>
    case getCourse
}

extension CurrentCourseAPI {
    var path: String {
        switch self {
        case .getCourse:
            return HTTPMethodURL.GET.course
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourse:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCourse:
            return .requestPlain
        }
    }
}
