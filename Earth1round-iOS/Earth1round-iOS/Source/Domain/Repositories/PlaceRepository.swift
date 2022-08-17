//
//  PlaceRepository.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/16.
//

import Foundation

import RxSwift

protocol PlaceRepository {
    func places() -> Observable<[Place]>
}
