//
//  MyRecordUseCase.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift

protocol MyRecordUseCase {
    func load() -> Observable<[MyRecord]>
}

final class DefaultMyRecordUseCase: MyRecordUseCase {
    
    private let repository: MyRecordRepository
    
    init(repository: MyRecordRepository) {
        self.repository = repository
    }
    
    func load() -> Observable<[MyRecord]> {
        return self.repository.load()
    }
    
}
