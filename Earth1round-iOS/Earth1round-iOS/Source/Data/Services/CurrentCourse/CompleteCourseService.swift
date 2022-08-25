//
//  CompleteCourseService.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import Moya

public class CompleteCourseService {
    
    static let shared = CompleteCourseService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func complete(completion: @escaping (Result<GenericResponse<CompleteCourse>?, Error>) -> Void) {
        
        provider.requestDecoded(CompleteCourseAPI.complete) { response in
            completion(response)
        }
    }
    
}
