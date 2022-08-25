//
//  MyRecordViewModel.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift

protocol MyRecordViewModel {
    func load() -> Observable<[MyRecord]>
}


final class DefaultMyRecordViewModel: MyRecordViewModel {
    private let useCase: DefaultMyRecordUseCase
    
    public init(myRecordUseCase: DefaultMyRecordUseCase) {
        self.useCase = myRecordUseCase
    }
        
    func load() -> Observable<[MyRecord]>{
        return self.useCase.load()
    }
    

}
