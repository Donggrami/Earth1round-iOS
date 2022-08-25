//
//  CourseAPI.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import Moya

enum CreateCourseAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<Int>
    case createCourse(requset: CourseRequestModel)
}

extension CreateCourseAPI {
    var path: String {
        switch self {
        case .createCourse:
            return HTTPMethodURL.POST.course
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createCourse:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createCourse(let request):
            return .requestParameters(parameters: ["start_place_id": request.startPlaceID,
                                                   "end_place_id": request.endPlaceID,
                                                   "distance": request.distance],
                                      encoding: JSONEncoding.default)
        }
    }
}
