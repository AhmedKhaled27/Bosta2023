//
//  AlbumPhotosEndPoint.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import Moya

enum AlbumPhotosEndPoint {
    case albumPhotos(albumId: Int)
}

extension AlbumPhotosEndPoint: TargetType, BaseURLProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    
    var path: String {
        switch self {
        case .albumPhotos: return "photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .albumPhotos: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .albumPhotos(albumId):
            let params = ["albumId" : albumId]
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
