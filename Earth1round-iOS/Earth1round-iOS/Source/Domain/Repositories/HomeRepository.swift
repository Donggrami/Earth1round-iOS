//
//  HomeRepository.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import RxSwift

protocol HomeRepository {
    func loadUser() -> Observable<HomeUser>
    func getCustomNumber() -> Observable<Character>
}
