//
//  CurrentCourseRepository.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import RxSwift
import Moya

class CurrentCourseRepository: CourseRepository {
    
    func course() -> Observable<Course> {
        let observable = Observable<Course>.create { observer -> Disposable in
            let requestReference: () = CourseService.shared.getCourse { response in
                switch response {
                case .success(let data):
                    if let data = data,
                       let result = data.result {
                        observer.onNext(result)
                    }
                case .failure(let err):
                    print(err)
                }
            }
            return Disposables.create(with: { requestReference })
        }
        return observable
    }
    
}
