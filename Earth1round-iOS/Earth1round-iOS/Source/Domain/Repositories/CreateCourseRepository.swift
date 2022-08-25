//
//  CreateCourseRepository.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift

protocol CreateCourseRepository {
    func createCourse(request: CourseRequestModel) -> Observable<Int>
}
