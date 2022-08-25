//
//  DefaultMyRecordRepository.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift
import Moya

class DefaultMyRecordRepository: MyRecordRepository {
    
    func load() -> Observable<[MyRecord]> {
        let observable = Observable<[MyRecord]>.create { observer -> Disposable in
            let requestReference: () = MyRecordService.shared.getRecord { response in
                switch response {
                case .success(let data):
                    if let data = data,
                       let result = data.result {
                        observer.onNext(result)
                    }
                case .failure(let err):
                    print(err)
                }
            }
            return Disposables.create(with: { requestReference })
        }
        return observable
    }
    
}
