//
//  APIService.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import Moya
import RxMoya
import RxSwift

public class APIService<T> where T: TargetType {
    
    //MARK: Attributes
    private let provider: MoyaProvider<T>
    
    private let jsonDataFormatter = { (_ data: Data) -> String  in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    private let endpointClosure = { (target: T) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        var request = try? defaultEndpoint.urlRequest()
        request?.cachePolicy = .useProtocolCachePolicy
        debugPrint(request?.urlRequest?.url ?? "")
        return defaultEndpoint
    }
    
    // MARK: Initializer
    init() {
        provider = MoyaProvider<T>()
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 20
        provider.session.sessionConfiguration.timeoutIntervalForResource = 20
    }
    
    func request<C: Codable>(target: T, objType: C.Type) -> Observable<C>  {
        return provider
            .rx
            .request(target)
            .filterSuccessfulStatusCodes()
            .map(objType)
            .asObservable()
    }
}
