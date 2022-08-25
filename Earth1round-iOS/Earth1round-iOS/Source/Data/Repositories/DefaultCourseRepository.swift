//
//  DefaultCourseRepository.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift
import Moya

class DefaultCourseRepository: CourseRepository {
    func createCourse(request: CourseRequestModel) -> Observable<Int> {
        Observable<Int>.create { observer -> Disposable in
            let requestReference: () = CourseService.shared.createCourse(request: request) { response in
                switch response {
                case .success(let statusCode):
                    if let statusCode = statusCode {
                        observer.onNext(statusCode)
                    }
                case .failure(let err):
                    print(err)
                }
            }
            return Disposables.create(with: { requestReference })
        }
    }
    
}
