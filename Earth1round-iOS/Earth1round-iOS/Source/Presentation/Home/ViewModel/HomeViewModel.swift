//
//  HomeViewModel.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel {
    func load() -> Observable<HomeUser>
    func loadCharacter(input: Observable<Void>) -> Driver<Int>
}


final class DefaultHomeViewModel: HomeViewModel {
    private let useCase: DefaultHomeUseCase
    
    public init(homeUseCase: DefaultHomeUseCase) {
        self.useCase = homeUseCase
    }
        
    func load() -> Observable<HomeUser>{
        return self.useCase.loadUser()
    }
    
    func loadCharacter(input: Observable<Void>) -> Driver<Int> {
        let customNumber = input
            .flatMap {
                self.useCase.getCustomNumber()
            }.map { $0.customNum }
            .asDriver(onErrorJustReturn: 1)
        
        return customNumber
    }
}
