//
//  CharacterService.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import Moya

public class CharacterService {
    
    static let shared = CharacterService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func getCustomNumber(completion: @escaping (Result<GenericResponse<Character>?, Error>) -> Void) {
        provider.requestDecoded(CharacterAPI.getCustomNumber) { response in
            completion(response)
        }
    }
    
    func customCharacter(number: Int, completion: @escaping (Result<Int?, Error>) -> Void) {
        provider.requestNoResultAPI(CharacterAPI.customCharacter(request: number)) { response in
            completion(response)
        }
    }
    
}
