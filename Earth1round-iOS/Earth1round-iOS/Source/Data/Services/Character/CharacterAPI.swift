//
//  CharacterAPI.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import Moya

enum CharacterAPI: BaseTargetType {
    typealias ResultModel = GenericResponse<Character>
    case getCustomNumber
    case customCharacter(request: Int)
}

extension CharacterAPI {
    var path: String {
        switch self {
        case .getCustomNumber:
            return HTTPMethodURL.GET.custom
        case .customCharacter:
            return HTTPMethodURL.PATCH.custom
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCustomNumber:
            return .get
        case .customCharacter:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .getCustomNumber:
            return .requestPlain
        case .customCharacter(let request):
            return .requestParameters(parameters: ["custom_num": request],
                                      encoding: JSONEncoding.default)
        }
    }
}
