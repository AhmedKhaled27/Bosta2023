//
//  AlbumPhotosRemoteDataManager.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import RxSwift

class AlbumPhotosRemoteDataManager: APIService<AlbumPhotosEndPoint>, AlbumPhotosRemoteDataManagerProtocol {
    func getAlbumPhotos(albumId: Int) -> Observable<[AlbumPhoto]> {
        request(target: .albumPhotos(albumId: albumId),
                objType: [AlbumPhoto].self)
    }
}
