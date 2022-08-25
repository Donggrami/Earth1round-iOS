//
//  HomeUseCase.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func loadUser() -> Observable<HomeUser>
}

final class DefaultHomeUseCase: HomeUseCase {
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func loadUser() -> Observable<HomeUser> {
        return self.repository.loadUser()
    }
    
}
