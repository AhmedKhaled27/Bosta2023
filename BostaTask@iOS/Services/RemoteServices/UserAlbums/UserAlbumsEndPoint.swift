//
//  UserAlbumsEndPoint.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import Moya

enum UserAlbumsEndPoint {
    case userAlbums(userId: Int)
}

extension UserAlbumsEndPoint: TargetType, BaseURLProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    
    var path: String {
        switch self {
        case .userAlbums: return "albums"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userAlbums: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .userAlbums(userId):
            let params = ["userId" : userId]
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
