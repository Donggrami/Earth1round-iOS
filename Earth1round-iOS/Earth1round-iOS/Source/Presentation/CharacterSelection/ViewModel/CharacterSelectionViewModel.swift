//
//  CharacterSelectionViewModel.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift
import RxCocoa

final class CharacterSelectionViewModel {
    let disposeBag = DisposeBag()
    private let characterUseCase: CharacterUseCase
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let selectButtonControlEvent: ControlEvent<Void>
        let selectedCustiomNumber: ControlEvent<IndexPath>
    }
    
    struct Output {
        let customNumber: Driver<Int>
        let statusCode: Driver<Int>
    }
    
    init(characterUseCase: CharacterUseCase) {
        self.characterUseCase = characterUseCase
    }
    
    func transform(input: Input) -> Output {
        
        let customNumber = input.viewWillAppear
            .flatMap {
                self.characterUseCase.getCustomNumber()
            }.map { $0.customNum }
            .asDriver(onErrorJustReturn: 1)
        
        let customCharacter = input.selectButtonControlEvent
            .withLatestFrom(input.selectedCustiomNumber)
            .map { $0.row }
            .flatMap { self.characterUseCase.customCharacter(number: $0) }
            .share()
        
        let statusCode = customCharacter
            .compactMap { $0 }
            .map { response -> Int in
                return response
            }.asDriver(onErrorJustReturn: 404)
        
        return Output(customNumber: customNumber, statusCode: statusCode)
    }
    
}
