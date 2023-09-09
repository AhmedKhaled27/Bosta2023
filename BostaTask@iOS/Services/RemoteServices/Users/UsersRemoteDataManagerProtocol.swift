//
//  UsersRemoteDataManagerProtocol.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import RxSwift

protocol UsersRemoteDataManagerProtocol {
    func getUsersData() -> Observable<User>
}
