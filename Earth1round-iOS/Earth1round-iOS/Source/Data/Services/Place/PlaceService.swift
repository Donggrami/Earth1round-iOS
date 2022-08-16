//
//  PlaceService.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/14.
//

import Foundation

import Moya

public class PlaceService {
    
    static let shared = PlaceService()
    let provider = MultiMoyaProvider(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func getPlaces(completion: @escaping (Result<GenericResponse<[Place]>?, Error>) -> Void) {
        provider.requestDecoded(PlaceAPI.getPlaces) { response in
            completion(response)
        }
    }
    
}
