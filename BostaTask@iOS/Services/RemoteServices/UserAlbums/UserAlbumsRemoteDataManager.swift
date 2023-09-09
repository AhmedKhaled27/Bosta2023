//
//  UserAlbumsRemoteDataManager.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import RxSwift

class UserAlbumsRemoteDataManager: APIService<UserAlbumsEndPoint>, UserAlbumsRemoteDataManagerProtocol {
    func getUserAlbums(userId: Int) -> Observable<[UserAlbum]> {
        request(target: .userAlbums(userId: userId),
                objType: [UserAlbum].self)
    }
}
