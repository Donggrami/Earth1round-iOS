//
//  PlaceUseCase.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/16.
//

import Foundation

import RxSwift

protocol PlaceUseCase {
    func places() -> Observable<[Place]>
}

final class DefaultPlaceUseCase: PlaceUseCase {
    
    private let repository: PlaceRepository
    
    init(repository: PlaceRepository) {
        self.repository = repository
    }
    
    func places() -> Observable<[Place]> {
        return self.repository.places()
    }
    
}
