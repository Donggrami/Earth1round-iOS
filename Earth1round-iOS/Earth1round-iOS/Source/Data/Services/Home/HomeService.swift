//
//  HomeService.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import Moya

public class HomeService {
    
    static let shared = HomeService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func getUser(completion: @escaping (Result<GenericResponse<HomeUser>?, Error>) -> Void) {
        
        provider.requestDecoded(HomeAPI.getUser) { response in
            completion(response)
        }
    }
    
}
