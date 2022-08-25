//
//  CharacterUseCase.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift

protocol CharacterUseCase {
    func getCustomNumber() -> Observable<Character>
    func customCharacter(number: Int) -> Observable<Int>
}

final class DefaultCharacterUseCase: CharacterUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func getCustomNumber() -> Observable<Character> {
        return self.repository.getCustomNumber()
    }
    
    func customCharacter(number: Int) -> Observable<Int> {
        return self.repository.customCharacter(number: number)
    }
    
}
