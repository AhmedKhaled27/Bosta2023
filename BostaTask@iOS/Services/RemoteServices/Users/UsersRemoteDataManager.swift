//
//  UsersRemoteDataManager.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import RxSwift

class UsersRemoteDataManager: APIService<UsersEndPoint>, UsersRemoteDataManagerProtocol {
    func getUsersData() -> Observable<User> {
        request(target: .usersData,
                objType: [User].self).map({$0.randomElement()!})
    }
}
