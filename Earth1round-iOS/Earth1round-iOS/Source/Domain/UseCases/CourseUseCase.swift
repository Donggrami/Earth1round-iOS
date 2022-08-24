//
//  CourseUseCase.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import RxSwift

protocol CourseUseCase {
    func course() -> Observable<Course>
}

final class CurrentCourseUseCase: CourseUseCase {
    
    private let repository: CourseRepository
    
    init(repository: CourseRepository) {
        self.repository = repository
    }
    
    func course() -> Observable<Course> {
        return self.repository.course()
    }
    
}