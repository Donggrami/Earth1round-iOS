//
//  BaseTargetType.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/12.
//

import Foundation

import Moya

protocol BaseTargetType: Moya.TargetType {
    associatedtype ResultModel: Decodable
}

extension BaseTargetType {

    var baseURL: URL {
        let url = Config.Network.baseURL
        return URL(string: "http://" + url)!
    }

    var headers: [String: String]? {
        let token = KeyChainService.read(key: KeyChain.accessToken.rawValue) ?? ""
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token]
        return header
    }

    var sampleData: Data {
        return Data()
    }

}
