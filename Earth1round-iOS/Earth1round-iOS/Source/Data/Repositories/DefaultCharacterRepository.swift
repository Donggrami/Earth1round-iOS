//
//  DefaultCharacterRepository.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift
import Moya

class DefaultCharacterRepository: CharacterRepository {

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
    
    func customCharacter(number: Int) -> Observable<Int> {
        Observable<Int>.create { observer -> Disposable in
            let requestReference: () = CharacterService.shared.customCharacter(number: number) { response in
                switch response {
                case .success(let statusCode):
                    if let statusCode = statusCode {
                        observer.onNext(statusCode)
                    }
                case .failure(let err):
                    print(err)
                }
            }
            return Disposables.create(with: { requestReference })
        }
    }
    
}
