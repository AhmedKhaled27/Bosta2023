//
//  AlbumPhotosRemoteDataManagerProtocol.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import RxSwift

protocol AlbumPhotosRemoteDataManagerProtocol {
    func getAlbumPhotos(albumId: Int) -> Observable<[AlbumPhoto]>
}
