//
//  HomeViewModel.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift

protocol HomeViewModel {
    func load() -> Observable<HomeUser>
}


final class DefaultHomeViewModel: HomeViewModel {
    private let useCase: DefaultHomeUseCase
    
    public init(homeUseCase: DefaultHomeUseCase) {
        self.useCase = homeUseCase
    }
        
    func load() -> Observable<HomeUser>{
        return self.useCase.loadUser()
    }
    

}
