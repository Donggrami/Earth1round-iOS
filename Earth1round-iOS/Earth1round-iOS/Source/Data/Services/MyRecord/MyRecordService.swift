//
//  MyRecordService.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/25.
//

import Foundation
import Moya

public class MyRecordService {
    
    static let shared = MyRecordService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func getRecord(completion: @escaping (Result<GenericResponse<[MyRecord]>?, Error>) -> Void) {
        
        provider.requestDecoded(MyRecordAPI.getRecord) { response in
            completion(response)
        }
    }
    
}
