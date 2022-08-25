//
//  CourseService.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import Moya

public class CreateCourseService {
    
    static let shared = CreateCourseService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func createCourse(request: CourseRequestModel, completion: @escaping (Result<Int?, Error>) -> Void) {
        provider.requestNoResultAPI(CreateCourseAPI.createCourse(requset: request)) { response in
            completion(response)
        }
    }
    
}
