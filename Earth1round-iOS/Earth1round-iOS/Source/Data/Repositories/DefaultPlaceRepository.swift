//
//  DefaultPlaceRepository.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/16.
//

import Foundation

import RxSwift
import Moya

class DefaultPlaceRepository: PlaceRepository {
    
    func places() -> Observable<[Place]> {
        let observable = Observable<[Place]>.create { observer -> Disposable in
            let requestReference: () = PlaceService.shared.getPlaces { response in
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
