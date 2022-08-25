//
//  CourseUseCase.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import RxSwift

protocol CourseUseCase {
    func course() -> Observable<CurrentCourse>
    func complete() -> Observable<CompleteCourse>
    func getCustomNumber() -> Observable<Character>
}

final class CurrentCourseUseCase: CourseUseCase {
    
    private let repository: CourseRepository
    
    init(repository: CourseRepository) {
        self.repository = repository
    }
    
    func course() -> Observable<CurrentCourse> {
        return self.repository.course()
    }
    
    func complete() -> Observable<CompleteCourse> {
        return self.repository.complete()
    }
    
    func getCustomNumber() -> Observable<Character> {
        return self.repository.getCustomNumber()
    }
}
