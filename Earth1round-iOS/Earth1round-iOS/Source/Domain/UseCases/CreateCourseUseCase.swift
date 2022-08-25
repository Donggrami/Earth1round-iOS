//
//  CourseUseCase.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift

protocol CreateCourseUseCase {
    func createCourse(request: CourseRequestModel) -> Observable<Int>
}

final class DefaultCourseUseCase: CreateCourseUseCase {
    
    private let repository: CreateCourseRepository
    
    init(repository: CreateCourseRepository) {
        self.repository = repository
    }

    func createCourse(request: CourseRequestModel) -> Observable<Int> {
        return self.repository.createCourse(request: request)
    }

}
