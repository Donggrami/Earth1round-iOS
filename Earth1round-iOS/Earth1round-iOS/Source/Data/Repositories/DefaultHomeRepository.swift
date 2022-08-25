//
//  DefaultHomeRepository.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift
import Moya

class DefaultHomeRepository: HomeRepository {
    
    func loadUser() -> Observable<HomeUser> {
        let observable = Observable<HomeUser>.create { observer -> Disposable in
            let requestReference: () = HomeService.shared.getUser { response in
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
    
    func getCustomNumber() -> Observable<Character> {
        let observable = Observable<Character>.create { observer -> Disposable in
            let requestReference: () = CharacterService.shared.getCustomNumber { response in
                switch response {
                case .success(let data):
                    if let data = data, let result = data.result {
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
