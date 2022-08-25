//
//  CourseService.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import Moya

public class CurrentCourseService {
    
    static let shared = CurrentCourseService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func getCourse(completion: @escaping (Result<GenericResponse<CurrentCourse>?, Error>) -> Void) {
        
        provider.requestDecoded(CurrentCourseAPI.getCourse) { response in
            completion(response)
        }
    }
    
}
