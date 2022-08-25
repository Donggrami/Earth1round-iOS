//
//  CourseService.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import Moya

public class CourseService {
    
    static let shared = CourseService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func createCourse(request: CourseRequestModel, completion: @escaping (Result<Int?, Error>) -> Void) {
        provider.requestNoResultAPI(CourseAPI.createCourse(requset: request)) { response in
            completion(response)
        }
    }
    
}
