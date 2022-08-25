//
//  CourseUseCase.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift

protocol CourseUseCase {
    func createCourse(request: CourseRequestModel) -> Observable<Int>
}

final class DefaultCourseUseCase: CourseUseCase {
    
    private let repository: CourseRepository
    
    init(repository: CourseRepository) {
        self.repository = repository
    }

    func createCourse(request: CourseRequestModel) -> Observable<Int> {
        return self.repository.createCourse(request: request)
    }

}
