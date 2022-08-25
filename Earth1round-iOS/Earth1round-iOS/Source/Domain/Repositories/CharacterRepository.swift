//
//  CharacterRepository.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift

protocol CharacterRepository {
    func getCustomNumber() -> Observable<Character>
    func customCharacter(number: Int) -> Observable<Int>
}
