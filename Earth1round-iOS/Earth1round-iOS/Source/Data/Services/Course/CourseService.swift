//
//  CourseService.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import Moya

public class CourseService {
    
    static let shared = CourseService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func getCourse(completion: @escaping (Result<GenericResponse<Course>?, Error>) -> Void) {
        
        provider.requestDecoded(CourseAPI.getCourse) { response in
            completion(response)
        }
    }
    
}
