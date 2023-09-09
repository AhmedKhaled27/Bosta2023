//
//  UsersEndPoints.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import Moya

enum UsersEndPoint {
    case usersData
}

extension UsersEndPoint: TargetType, BaseURLProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    
    var path: String {
        switch self {
        case .usersData: return "users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .usersData: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .usersData: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
