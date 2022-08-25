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
//        let token = KeyChainService.read(key: KeyChain.accessToken.rawValue) ?? ""
        let token = "eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyX2lkIjo1LCJpYXQiOjE2NjEzMTk0MjMsImV4cCI6MTY2MTU3ODYyM30.0giPym7fg9OGXZzzTU6tjZBqd_9tEqZD6_WRHGvZg_I"
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token]
        return header
    }

    var sampleData: Data {
        return Data()
    }

}
