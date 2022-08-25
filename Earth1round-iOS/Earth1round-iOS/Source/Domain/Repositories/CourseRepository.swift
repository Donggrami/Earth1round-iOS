//
//  CourseRepository.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import RxSwift

protocol CourseRepository {
    func course() -> Observable<CurrentCourse>
    func complete() -> Observable<CompleteCourse>
    func getCustomNumber() -> Observable<Character>
}
