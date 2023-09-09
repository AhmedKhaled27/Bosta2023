//
//  AlbumPhotosViewModel.swift
//  BostaTask@iOS
//
//  Created by Ahmed Khaled on 09/09/2023.
//

import RxSwift
import RxCocoa

class AlbumPhotosViewModel: AlbumsPhotosViewModelProtocol {    
    //MARK: Properites
    var albumPhotosRemoteDataManager: AlbumPhotosRemoteDataManagerProtocol
    
    private var imagesModelBehavior = BehaviorRelay<[AlbumPhoto]>(value: [])
    var filteredImagesModelBehavior = BehaviorRelay<[AlbumPhoto]>(value: [])
    
    var searchKey:BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    private let errorSubject = PublishSubject<Error>()
    var errorObservable: Observable<Error> {
        return errorSubject.asObservable()
    }
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()
    var albumId: Int
    
    //MARK: Initializer
    init(albumId: Int,
         albumPhotosRemoteDataManager: AlbumPhotosRemoteDataManagerProtocol){
        self.albumPhotosRemoteDataManager = albumPhotosRemoteDataManager
        self.albumId = albumId
        subscribeToSearchBarTextAndFilter()
        getAlbumImages(albumId: albumId)
    }
    
    //MARK: Deaalocation
    deinit {
        debugPrint("\(AlbumPhotosViewModel.self) release from memory")
    }
    
}

//MARK: Helper Functions
extension AlbumPhotosViewModel {
    private func getAlbumImages(albumId: Int) {
        
        albumPhotosRemoteDataManager
            .getAlbumPhotos(albumId: albumId)
            .subscribe(onNext: { [weak self] albumPhotos in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                self.imagesModelBehavior.accept(albumPhotos)
                self.filteredImagesModelBehavior.accept(albumPhotos)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                self.errorSubject.onNext(error)
            }).disposed(by: disposeBag)
        
    }
    
    private func subscribeToSearchBarTextAndFilter(){
        searchKey.bind { searchKey in
            let filterdImages = self.imagesModelBehavior.value.filter({ image in
                searchKey.isEmpty ||  image.title.lowercased().contains(searchKey.lowercased())
            })
            self.filteredImagesModelBehavior.accept(filterdImages)
        }.disposed(by: disposeBag)
    }
}
