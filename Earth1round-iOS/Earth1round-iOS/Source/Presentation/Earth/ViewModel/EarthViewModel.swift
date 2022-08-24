//
//  EarthView.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/23.
//

import Foundation
import RxSwift

protocol EarthViewModel {
    func load() -> Observable<Course>
}


final class DefaultEarthViewModel: EarthViewModel {
    private let useCase: CourseUseCase
    
    public init(courseUseCase: CurrentCourseUseCase) {
        self.useCase = courseUseCase
    }
        
    func load() -> Observable<Course>{
        return self.useCase.course()
    }
    

}
