//
//  AlbumPhotosProtocols.swift
//  BostaTask@iOS
//
//  Created by Ahmed Khaled on 09/09/2023.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: ViewModel
protocol AlbumsPhotosViewModelProtocol {
    //Properites
    var albumPhotosRemoteDataManager: AlbumPhotosRemoteDataManagerProtocol {get set}
    var filteredImagesModelBehavior: BehaviorRelay<[AlbumPhoto]> {get}
    var errorObservable: Observable<Error> {get}
    var loadingBehavior: BehaviorRelay<Bool> {get set}
    
    var searchKey: BehaviorRelay<String> {get set}

    //Functions
    
}
